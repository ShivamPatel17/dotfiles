-- NOTE
-- if the lsp isn't started from opening a file, force the LSP to set up with
-- `:Lazy load nvim-lspconfig`

-- Load default configurations from NvChad
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- List of servers to set up with default configuration
local servers = { "html", "cssls", "gopls", "solargraph", "protols" } -- Add gopls for Go

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

-- configruation for protols https://github.com/mason-org/mason-registry/pull/6219
-- https://github.com/coder3101/protols
lspconfig.protols.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "proto" },
}

lspconfig.pylsp.setup {
  on_attach = nvlsp.on_attach, -- If you have a custom on_attach
  on_init = nvlsp.on_init, -- If you have a custom on_init
  capabilities = nvlsp.capabilities, -- If you have custom capabilities
  filetypes = { "python" },
  settings = {
    pylsp = {
      plugins = {
        ruff = { enabled = true },
        -- Other plugins (optional)
        pycodestyle = {
          ignore = {
            "E501",
            "W503", -- line break before every binary operator
            "E203", -- whitespace before :
          },
        },
        mypy = {
          enabled = true,
          live_mode = false, -- or true, depending on your preference.
          args = { "--follow-imports=silent", "--ignore-missing-imports" }, -- Optional mypy arguments
        },
      },
    },
  },
}

lspconfig.ruff.setup {
  on_attach = nvlsp.on_attach, -- If you have a custom on_attach
  on_init = nvlsp.on_init, -- If you have a custom on_init
  capabilities = nvlsp.capabilities, -- If you have custom capabilities
  filetypes = { "python" },
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    },
  },
}

lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach, -- If you have a custom on_attach
  on_init = nvlsp.on_init, -- If you have a custom on_init
  capabilities = nvlsp.capabilities, -- If you have custom capabilities
  filetypes = { "python" },
  init_options = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic", -- or "off", "strict"
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
}
