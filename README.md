# awsecret.nvim

awsecret.nvim is a Neovim plugin for securely fetching and caching secrets from AWS Secrets Manager, making it easy to retrieve and use secrets directly in your editor. The plugin integrates seamlessly with Telescope for secret selection and displays secret values in a floating window.

## Features

- Fetch secrets from AWS Secrets Manager.

- Cache secrets locally to avoid redundant API calls.

- Select secrets interactively using Telescope.

- Display secret values in a floating window with text wrapping.

- Configurable key mappings for fetching and retrieving secrets.

## Installation

### Using Lazy.nvim

Add the plugin to your plugins.lua

```lua
return {
  {
    "rahulmlokurte/awsecret.nvim",
  }
}
```

## Configuration

You can configure the plugin by passing options to the **setup** function.

```lua
require("awsecret").setup(
{
  cache_path = vim.fn.stdpath("data") .. "/awsecret_cache.json", -- Path to store cached secrets
}
)
```

## Default Keybinds

`awsecret.nvim` comes with some default keybinds!

| Key         | Description                             |
| ----------- | --------------------------------------- |
| `<leader>smf` | Fetch Secrets from secret manager       |
| `<leader>sms` | Select the key from the fetched secrets |

## Usage

### Fetch and Cache Secrets

- `AwsecretFetch` # Fetch and Cache the secrets

- Enter the AWS secret key when prompted.

- The secret is fetched from AWS Secrets Manager and cached locally.

### Retrieve and Display Secret Values

- `AwsecretSelect` # Select the secret key

- Use Telescope to select a cached secret key.

- The value of the selected secret is notified

## Requirements

- Neovim > 10.0

- AWS CLI configured with appropriate credentials.

- Telescope.nvim (for interactive secret selection).

## Example Workflow

1. Setup AWS Credentials:

Ensure your AWS CLI is configured with valid credentials to access Secrets Manager

2. Fetch Secrets:

- Trigger the fetch key mapping (e.g., <leader>smf).

- Enter the secret key (e.g., my-secret-key).

- The secret is fetched and cached locally.

3. Select and View Secrets:

- Trigger the select key mapping (e.g., <leader>sms).

- Use Telescope to select a key.

- The value is displayed in a floating window.

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.
