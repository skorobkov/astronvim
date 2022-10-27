local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
  },

  -- Set colorscheme to use
  -- colorscheme = "catppuccin",
    colorscheme = "tokyonight-night",
  -- colorscheme = "default_theme",

  lsp = {
    servers = {
      -- "rust_analyzer",
      "pyright",
      "ansiblels",
      "yamlls",
      "gopls",
    },
    skip_setup = { "rust_analyzer" },
  },

 -- Configure plugins
  plugins = {
    init = {
      {
        "folke/tokyonight.nvim",
        as = "tokionight",
        config = function()
          require("tokyonight").setup {}
        end,
      },
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup {}
        end,
      },
      {
        "simrat39/rust-tools.nvim",
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          require("rust-tools").setup {
            server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
          }
        end,
      }, 
    },
    heirline = function(config)
      -- the first element of the default configuration table is the statusline
      config[1] = {
        -- set the fg/bg of the statusline
        hl = { fg = "fg", bg = "bg" },
        -- when adding the mode component, enable the mode text with padding to the left/right of it
        astronvim.status.component.mode { mode_text = { padding = { left = 1, right = 1 } } },
        -- add all the other components for the statusline
        astronvim.status.component.git_branch(),
        astronvim.status.component.file_info(),
        astronvim.status.component.git_diff(),
        astronvim.status.component.diagnostics(),
        astronvim.status.component.fill(),
        astronvim.status.component.macro_recording(),
        astronvim.status.component.fill(),
        astronvim.status.component.lsp(),
        astronvim.status.component.treesitter(),
        astronvim.status.component.nav(),
      }
      -- config[2] = nil
      -- return the final configuration table
      return config
    end,
  },
}

return config
