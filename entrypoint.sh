#!/bin/sh
set -e

PORT="${INPUT_PORT:-1153}"
VERSION="${INPUT_VERSION:-latest}"
IMAGE="ghcr.io/liveblocks/liveblocks/dev-server:${VERSION}"

echo "Pulling ${IMAGE}..."
docker pull "$IMAGE"

echo "Starting Liveblocks dev server (version: ${VERSION}, port: ${PORT})..."
docker run -d \
  --name liveblocks-dev-server \
  -p "${PORT}:${PORT}" \
  "$IMAGE" \
  --port "${PORT}"

# Wait for the container's built-in HEALTHCHECK to report healthy
echo "Waiting for server to be ready..."
for i in $(seq 1 60); do
  STATUS=$(docker inspect --format='{{.State.Health.Status}}' liveblocks-dev-server 2>/dev/null || echo "starting")
  case "$STATUS" in
    healthy)
      echo "Liveblocks dev server is ready at http://localhost:${PORT}"
      echo "url=http://localhost:${PORT}" >> "$GITHUB_OUTPUT"
      exit 0
      ;;
    unhealthy)
      echo "::error::Liveblocks dev server failed health check"
      docker logs liveblocks-dev-server
      exit 1
      ;;
  esac
  sleep 2
done

echo "::error::Timed out waiting for Liveblocks dev server (120s)"
docker logs liveblocks-dev-server
exit 1
