local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

return {
--  on_attach=on_attach,
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          groups = "module",
        },
        prefix = "self",
      },
      rustfmt = {
        rangeFormatting = {
          enable = true,
        },
      },
      cargo = {
        allFeatures = true,
        fmt_on_save = true,
      },
      check_on_save = {
        command = 'clippy',
        extraArgs = {
          "--no-deps",
          "--",
          "--warn",
          "clippy::pedantic",
        },
      },
      workspace = {
        symbol = {
          search = {
            kind = "all_symbols"
          },
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

