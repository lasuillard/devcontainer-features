
# OpenTofu (opentofu)

A feature to install OpenTofu and relevant tools.

## Example Usage

```json
"features": {
    "ghcr.io/lasuillard/devcontainer-features/opentofu:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| opentofu-version | The version of OpenTofu to install. | string | latest |
| terraform-is-tofu | Whether to install Terraform. | boolean | false |
| install-terragrunt | Whether to install Terragrunt. Use 'latest' to install the latest version. Use 'none' to skip installation. | string | none |
| install-terraform-docs | Whether to install terraform-docs. Use 'latest' to install the latest version. Use 'none' to skip installation. | string | none |

## Customizations

### VS Code Extensions

- `gamunu.opentofu`



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/lasuillard/devcontainer-features/blob/main/src/opentofu/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
