#!/bin/bash

# Shell scripts for push/pull to v2 registry
#
# - Get a token.
# - Push a blob.
# - Pull that blob repeatedly.
#
# Tested on OS X 10.10.3, curl 7.38.0, jq-1.4
#

# ref: https://gist.github.com/jlhawn/8f218e7c0b14c941c41f

reponame="jlhawn/test-script"

getLogin() {
    read -p "Please enter username (or empty for anonymous): " username
    if [ -n "$username" ]; then
        read -s -p "password: " password
        echo
    fi
}

getToken() {
    local reponame=$1
    local actions=$2
    local headers
    local response

    if [ -n "$username" ]; then
        headers="Authorization: Basic $(echo -n "${username}:${password}" | base64)"
    fi

    response=$(curl -s -H "$headers" "https://auth.docker.io/token?service=registry.docker.io&scope=repository:$reponame:$actions")

    echo $response | jq '.token' | xargs echo
}

uploadBlob() {
    local reponame=$1
    local token=$(getToken $reponame "push,pull")
    local uploadURL
    local numBytes=10000000 # 10 Megabytes

    uploadURL=$(curl -siL -H "Authorization: Bearer $token" -X POST "https://registry-1.docker.io/v2/$reponame/blobs/uploads/" | grep 'Location:' | cut -d ' ' -f 2 | tr -d '[:space:]')

    blobDigest="sha256:$(head -c $numBytes /dev/urandom | tee upload.tmp | shasum -a 256 | cut -d ' ' -f 1)"

    echo "Uploading Blob of 10 Random Megabytes"
    time curl -T upload.tmp --progress-bar -H "Authorization: Bearer $token" "$uploadURL&digest=$blobDigest" > /dev/null
}

downloadBlob() {
    local reponame=$1
    local blobDigest=$2
    local token=$(getToken $reponame "pull")

    echo "Downloading Blob"
    time curl -L --progress-bar -H "Authorization: Bearer $token" "https://registry-1.docker.io/v2/$reponame/blobs/$blobDigest" > download.tmp
}

getLogin
uploadBlob $reponame

for i in {1..10}; do
    downloadBlob $reponame $blobDigest
done
