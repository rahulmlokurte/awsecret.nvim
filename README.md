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
  floating_window = {
    width = 0.5, -- Width of the floating window (as a percentage of the editor width)
    height = 0.3, -- Height of the floating window (as a percentage of the editor height)
    border = "rounded", -- Border style for the floating window
  },
}
)
```

## Usage

### Fetch and Cache Secrets

- Press the key mapping for fetching secrets (e.g., <leader>sf).

- Enter the AWS secret key when prompted.

- The secret is fetched from AWS Secrets Manager and cached locally.

### Retrieve and Display Secret Values

- Press the key mapping for selecting a secret (e.g., <leader>sg).

- Use Telescope to select a cached secret key.

- The value of the selected secret is displayed in a floating window.

## Requirements

- Neovim 0.8+

- AWS CLI configured with appropriate credentials.

- Telescope.nvim (for interactive secret selection).

## Example Workflow

1. Setup AWS Credentials:

Ensure your AWS CLI is configured with valid credentials to access Secrets Manager

2. Fetch Secrets:

- Trigger the fetch key mapping (e.g., <leader>sf).

- Enter the secret key (e.g., my-secret-key).

- The secret is fetched and cached locally.

3. Select and View Secrets:

- Trigger the select key mapping (e.g., <leader>sg).

- Use Telescope to select a key.

- The value is displayed in a floating window.

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.
