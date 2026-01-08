-- TidalCycles integration
return {
  "thgrund/tidal.nvim",
	enabled = true,
	lazy = false,
  opts = {
    --- Configure TidalLaunch command
    boot = {
      tidal = {
        --- Command to launch ghci with tidal installation
        cmd = "ghci",
        args = {
          "-v0",
        },
        --- Tidal boot file path
        file = os.getenv("HOME") .. "/.cabal/store/ghc-9.4.7/tidal-1.10.1-4acb9cda4e3272e067951dbf2c8c8e6f2e6aab2c34818d4d97f16e0ad87ca43a/share/BootTidal.hs",
        enabled = true,
        highlight = {
          autostart = true,
          styles = {
            osc = {
              ip = "127.0.0.1",
              port = 3335,
            },
            -- [Tidal ID] -> hl style
            --custom = {
            --  ["1"] = { bg = "#cc241d", foreground = "#ffffff" },
            --  ["2"] = { bg = "#d65d0e", foreground = "#ffffff" },
            --  ["3"] = { bg = "#d78821", foreground = "#000000" },
            --  ["4"] = { bg = "#b8bb26", foreground = "#000000" },
            --  ["5"] = { bg = "#98971a", foreground = "#000000" },
            --  ["6"] = { bg = "#689d6a", foreground = "#000000" },
            --  ["7"] = { bg = "#458588", foreground = "#ffffff" },
            --  ["8"] = { bg = "#d3869b", foreground = "#000000" },
            --},
            global = {
              baseName = "CodeHighlight",
              style = {
                bg = "#ff8800",
                foreground = "#000000"
              }
            },
          },
          events = {
            osc = {
              ip = "127.0.0.1",
              port = 6013,
            },
          },
          fps = 30,
        },
      },
      sclang = {
        --- Command to launch SuperCollider
        cmd = "sclang",
        args = {},
        --- SuperCollider boot file
        file = os.getenv("HOME") .. "/.config/tidal/BootSuperDirt.scd",
        enabled = true,
      },
      split = "v",
    },
    --- Default keymaps
    --- Set to false to disable all default mappings
    --- @type table | nil
    mappings = {
      send_line = { mode = { "n" }, key = "<C-e>" },
      send_visual = { mode = { "x" }, key = "<leader><CR>" },
      send_block = { mode = { "i", "n", "x" }, key = "<M-CR>" },
      send_node = { mode = "n", key = "<leader>kk" },
      send_silence = { mode = "n", key = "<leader>d" },
      send_hush = { mode = "n", key = "<leader><Esc>" },
    },
    ---- Configure highlight applied to selections sent to tidal interpreter
    selection_highlight = {
      --- Highlight definition table
      --- see ':h nvim_set_hl' for details
      --- @type vim.api.keyset.highlight
      highlight = { link = "IncSearch" },
      --- Duration to apply the highlight for
      timeout = 150,
    },
  },
  -- Recommended: Install TreeSitter parsers for Haskell and SuperCollider
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "haskell",
        "supercollider" ,
      }
    },
  },
}
