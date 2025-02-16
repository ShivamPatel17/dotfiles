-- Load default configurations from NvChad
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- List of servers to set up with default configuration
local servers = { "html", "cssls", "gopls", "solargraph" } -- Add gopls for Go

-- Set up each server with NvChad defaults
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Custom configuration for gopls
lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "gopls" }, -- Ensure gopls is in your PATH
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true, -- Detect unused parameters
        nilness = true, -- Check for nil-related issues
      },
      staticcheck = true, -- Enable additional static analysis
      completeUnimported = true, -- Auto-import packages
    },
  },
}

-- Configure Solargraph
lspconfig.solargraph.setup {
  cmd = { "/Users/shivampatel/.asdf/shims/solargraph", "stdio" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
    },
  },
  filetypes = { "ruby" }, -- Ensure filetypes are explicitly set
  root_dir = lspconfig.util.root_pattern("Gemfile", ".git"), -- Set root directory
}

-- configuration for typescript/javascript
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "javascript", "typescript" },
}

-- configruation for terraform
lspconfig.terraformls.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "terraform", "tf" },
}
