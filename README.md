# Liveblocks Dev Server Action

Start a [Liveblocks](https://liveblocks.io) dev server in your GitHub Actions
workflow for integration testing.

## Usage

```yaml
steps:
  - uses: liveblocks/dev-server@v1
    id: dev-server
    with:
      port: 1153

  - run: curl ${{ steps.dev-server.outputs.url }}/health
```

## Inputs

| Name      | Description                              | Default  |
| --------- | ---------------------------------------- | -------- |
| `port`    | Port to expose the dev server on         | `1153`   |
| `version` | CLI version to install (`latest`, `1.0.3`, etc.) | `latest` |

## Outputs

| Name  | Description                    |
| ----- | ------------------------------ |
| `url` | URL of the running dev server  |

The server is automatically stopped when the job completes.

## License

This action is licensed under the [Apache License 2.0](./LICENSE).

The Liveblocks dev server it runs is licensed under
[AGPL-3.0-or-later](https://github.com/liveblocks/liveblocks/blob/main/tools/liveblocks-cli/LICENSE).
