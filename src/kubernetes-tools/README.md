
# Kubernetes Tools (kubernetes-tools)

A feature to install K8s tools.

## Example Usage

```json
"features": {
    "ghcr.io/lasuillard/devcontainer-features/kubernetes-tools:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| kubectl-version | The version of kubectl to install, in format of 'v*'. | string | latest |
| install-krew | Whether to install Krew. Use 'latest' to install the latest version. Use 'none' to skip installation. | string | none |
| install-k9s | Whether to install k9s. Use 'latest' to install the latest version. Use 'none' to skip installation. | string | none |
| install-helm | Whether to install Helm. Use 'latest' to install the latest version. Use 'none' to skip installation. | string | none |

## Customizations

### VS Code Extensions

- `ms-kubernetes-tools.vscode-kubernetes-tools`
- `Tim-Koehler.helm-intellisense`



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/lasuillard/devcontainer-features/blob/main/src/kubernetes-tools/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
