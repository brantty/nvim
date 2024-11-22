local dev = true
local project = require("util.project")

local opts = {
  filetypes = {
    "*",
    ps1 = {
      RGB = false,
      css = false,
    },
    typescript = {
      css = false,
      names = true,
    },
    javascript = {
      css = false,
    },
    css = {
      names = true,
    },
    json = {
      css = false,
    },
    sh = {
      css = false,
    },
    mason = {
      css = false,
    },
    lazy = {
      RGB = false,
      css = false,
    },
    cmp_docs = {
      always_update = true,
    },
    cmp_menu = {
      always_update = true,
    },
    TelescopeResults = {
      RGB = false,
    },
    lua = {
      names = false,
    },
    vue = {
      names = true,
    },
    markdown = {
      RGB = false,
    },
    checkhealth = {
      names = false,
    },
    sshconfig = {
      names = false,
    },
    NeogitLogView = {
      RGB = false,
    },
  },
  user_default_options = {
    RGB = true,
    RRGGBB = true,
    names = true,
    RRGGBBAA = true,
    AARRGGBB = true,
    rgb_fn = true,
    hsl_fn = true,
    css = true,
    css_fn = true,
    mode = "background",
    tailwind = "both",
    sass = {
      enable = false,
      parsers = { "css" },
    },
    virtualtext = "■",
    virtualtext_inline = true,
    virtualtext_mode = "background",
  },
  buftypes = { "!prompt", "!popup" },
  user_commands = true,
}
-- red

local keys = project.get_keys("nvim-colorizer.lua")

local plugin = {
  opts = opts,
  keys = keys,
  event = "BufReadPre",
}

return dev
    and vim.tbl_extend("keep", plugin, {
      dir = "~/git/nvim-colorizer.lua",
      lazy = false,
    })
  or vim.tbl_extend("keep", plugin, {
    "NvChad/nvim-colorizer.lua",
    -- "catgoose/nvim-colorizer.lua",
    -- commit = "f134063618a65cad4d7415fddbd96ff7e0c5b4ae",
  })
