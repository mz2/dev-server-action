# Liveblocks Dev Server Action

A GitHub Action that starts a [Liveblocks](https://liveblocks.io) dev server for
integration testing. The server runs as a Docker container alongside your
workflow and is automatically cleaned up when the job finishes.

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

| Name      | Description                       | Default  |
| --------- | --------------------------------- | -------- |
| `port`    | Port to expose the dev server on  | `1153`   |
| `version` | Image tag to use (`latest`, `1.0.3`, `pr-3060`, etc.) | `latest` |

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

### Pin to a specific version

```yaml
- uses: liveblocks/dev-server@v1
  with:
    version: "1.0.5"
```

### Test a PR build of the dev server

```yaml
- uses: liveblocks/dev-server@v1
  with:
    version: pr-3060
```

## How it works

1. Pulls the `ghcr.io/liveblocks/liveblocks/dev-server` Docker image
2. Starts the dev server as a detached container
3. Waits for the built-in health check to report healthy (up to 120s)
4. Outputs the server URL for subsequent steps
5. Stops and removes the container when the job finishes (`post-entrypoint`)

## License

This action is licensed under the [Apache License 2.0](./LICENSE).

The Liveblocks dev server it runs is licensed under
[AGPL-3.0-or-later](https://github.com/liveblocks/liveblocks/blob/main/tools/liveblocks-cli/LICENSE).
