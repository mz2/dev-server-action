#!/bin/sh
echo "Stopping Liveblocks dev server..."
docker stop liveblocks-dev-server 2>/dev/null || true
docker rm liveblocks-dev-server 2>/dev/null || true
