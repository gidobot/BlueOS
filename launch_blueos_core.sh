#!/bin/bash
set -e

CONTAINER_NAME="blueos-core"
IMAGE="gidobot/blueos-core:master"

# Stop and remove existing container (volumes are separate and safe)
if [ "$(docker ps -aq -f name=${CONTAINER_NAME})" ]; then
    echo "Stopping and removing existing ${CONTAINER_NAME} container..."
    docker stop ${CONTAINER_NAME} > /dev/null
    docker rm ${CONTAINER_NAME} > /dev/null
fi

echo "Starting ${CONTAINER_NAME}..."

# Recreate with correct mounts
docker run -d \
    --name "${CONTAINER_NAME}" \
    --network host \
    --privileged \
    --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v blueos-core-config:/root/.config \
    -v blueos-core-firmware:/root/blueos-files \
    -v blueos-core-userdata:/usr/blueos/userdata \
    "${IMAGE}"

echo "-----------------------------------------------"
echo "BlueOS is now running."
echo "Access the web interface at: http://localhost"
echo "-----------------------------------------------"
