# Liveblocks dev server as a GitHub CI Action

A GitHub Action that starts a [Liveblocks](https://liveblocks.io) dev server for
integration testing. The server runs as a background process and is available to
all subsequent steps in the job.

## Quick start

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: liveblocks/dev-server@v1
        id: dev-server

      - run: curl ${{ steps.dev-server.outputs.url }}/health
        # => {"status":"ok"}

      - name: Run tests against the dev server
        run: npm test
        env:
          LIVEBLOCKS_BASE_URL: ${{ steps.dev-server.outputs.url }}
```

## Inputs

| Name   | Description                      | Default |
| ------ | -------------------------------- | ------- |
| `port` | Port to expose the dev server on | `1153`  |

## Outputs

| Name  | Description                   |
| ----- | ----------------------------- |
| `url` | URL of the running dev server |

## Examples

### Custom port

```yaml
- uses: liveblocks/dev-server@v1
  id: dev-server
  with:
    port: 8080

- run: curl http://localhost:8080/health
```

## How it works

1. Sets up [Bun](https://bun.sh) via `oven-sh/setup-bun`
2. Runs `bunx liveblocks dev` as a background process
3. Waits for the `/health` endpoint to respond (up to 30s)
4. Outputs the server URL for subsequent steps

The server process is automatically cleaned up when the runner shuts down.

## License

This action is licensed under the [Apache License 2.0](./LICENSE).

The Liveblocks dev server it runs is licensed under
[AGPL-3.0-or-later](https://github.com/liveblocks/liveblocks/blob/main/tools/liveblocks-cli/LICENSE).
