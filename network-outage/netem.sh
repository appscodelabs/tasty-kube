#!/usr/bin/env bash

set -e

# Get params
for i in "$@"
do
    case $i in
        -n=*|--name=*)
        KIND_CLUSTER="${i#*=}"
        shift
        ;;
        -r=*|--rate=*)
        RATE="${i#*=}"
        shift 
        ;;
        -d=*|--delay=*)
        DELAY="${i#*=}"
        shift
        ;;
        -l=*|--loss=*)
        LOSS="${i#*=}"
        shift
        ;;
        --reset)
        RESET="true"
        shift
        ;;
    esac
done
echo "CLUSTER = ${KIND_CLUSTER}"
echo "RATE    = ${RATE}"
echo "DELAY   = ${DELAY}"
echo "LOSS    = ${LOSS}"

# Check requirements
if ! command -v kind &> /dev/null ; then
  echo "KIND is not present!"
  exit 1
fi

# If we want to configure the outer interface of the 
# container we need this available in the host
# if ! command -v tc &> /dev/null ; then
#  echo "traffic control command is not present!"
#  exit 1
#fi

if ! lsmod | grep sch_netem &> /dev/null ; then
  echo "sch_netem kernel module is not loaded!"
  exit 1
fi

# Get kind nodes
NODES=$(kind get nodes --name ${KIND_CLUSTER:-"kind"})

if [[ -z $NODES ]]; then
  echo "no nodes found"
  exit 1
fi

# Configure network for each node in the cluster:
# - htb for rate limiting
# - netem for delay and packet loss
# Use the container internal interface
# so it can work in Mac and Windows.
# In Linux we can find the outer veth interface
# and configure it instead, to be more realistic
INTERFACE="eth0"
for n in $NODES; do
    CMD="docker exec -it ${n}"
    # delete any previous configuration (if exist)
    $CMD tc qdisc del dev ${INTERFACE} root || true
    if [[ ! -z $RESET ]]; then
        continue
    fi
    # set the parent for the netem configuration
    # use root if the rate is not enabled, otherwise
    # the parent will be the traffic class with the rate limit
    PARENT="root"
    if [[ ! -z $RATE ]]; then
        # set the root qdisc using HTB for rate limit
        $CMD tc qdisc add dev ${INTERFACE} root handle 1: htb
        # create a class to apply the rate limit
        $CMD tc class add dev ${INTERFACE} parent 1:1 classid 1:10 htb ${RATE:+rate $RATE}
        # set the class as parent of the netem qdisc
        PARENT="parent 1:10"
    fi
     # set the delay and the packet loss
    if [[ ! -z $DELAY ]] || [[ ! -z $LOSS ]]; then
        $CMD tc qdisc add dev ${INTERFACE} ${PARENT} netem ${DELAY:+delay $DELAY} ${LOSS:+loss $LOSS}
    fi
done

echo "Cluster network configured correctly"
exit 0