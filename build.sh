#!/bin/bash
# build.sh — builds and optionally pushes the alpine-image-builder Docker image.
#
# Usage:
#   ./build.sh                      # local build, tag :latest, FROM alpine:3.21
#   PUSH=true ./build.sh            # multi-arch build + push (requires buildx)
#   VERSION=3.21.0 PUSH=true ./build.sh  # tag release: pushes 3.21.0/3.21/3/latest/stable
#
# Environment:
#   DOCKER_USER     Docker Hub username (default: uwebarthel)
#   VERSION         Release version tag, e.g. 3.21.0 (default: empty = latest)
#   PUSH            Set to "true" to push to Docker Hub (default: false)
set -e

IMAGE_NAME="${DOCKER_USER:-uwebarthel}/alpine-image-builder"

if [ -n "${VERSION}" ]; then
  ALPINE_VERSION="${VERSION%.*}"   # major.minor, e.g. 3.21 from 3.21.0
  MAJOR="${VERSION%%.*}"
  MINOR="${VERSION%.*}"
  TAGS="--tag ${IMAGE_NAME}:${VERSION} \
        --tag ${IMAGE_NAME}:${MINOR} \
        --tag ${IMAGE_NAME}:${MAJOR} \
        --tag ${IMAGE_NAME}:latest \
        --tag ${IMAGE_NAME}:stable"
else
  ALPINE_VERSION="3.21"
  TAGS="--tag ${IMAGE_NAME}:latest"
fi

BUILD_ARGS="--build-arg ALPINE_VERSION=${ALPINE_VERSION}"

if [ "${PUSH:-false}" = "true" ]; then
  echo "Building and pushing multi-arch image: ${IMAGE_NAME} (alpine:${ALPINE_VERSION})"
  # shellcheck disable=SC2086
  docker buildx build \
    --platform linux/amd64,linux/arm64 \
    ${TAGS} \
    ${BUILD_ARGS} \
    --no-cache \
    --progress=plain \
    --push .
else
  echo "Building local image: ${IMAGE_NAME}:latest (alpine:${ALPINE_VERSION})"
  # shellcheck disable=SC2086
  docker build ${TAGS} ${BUILD_ARGS} .
fi
