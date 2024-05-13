--  TODO: 2024-04-12 - add linters for dotenv-linter

return {
  "mfussenegger/nvim-lint",
  event = "BufReadPre",
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d", "oxlint" },
      typescript = { "eslint_d", "oxlint" },
      vue = { "eslint_d", "oxlint" },
      docker = { "hadolint" },
      fish = { "fish" },
      -- env = { "dotenv-linter" },
      json = { "jsonlint" },
      markdown = { "markdownlint", "vale" },
      editorconfig = { "editorconfig-checker" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
    }

    lint.linters.codespell.args = { "--ignore-words=~/.config/codespell/ignore_word" }

    local ignore_buftype = {
      markdown = { "nofile" },
    }

    lint.linters.oxlint = {
      name = "oxlint", -- cargo install --features allocator --git https://github.com/oxc-project/oxc oxc_cli
      cmd = "oxlint",
      stdin = false,
      args = { "--format", "unix" },
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
        source = "oxlint",
        severity = vim.diagnostic.severity.WARN,
      }),
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function()
        if ignore_buftype[vim.bo.filetype] then
          for _, buftype in ipairs(ignore_buftype[vim.bo.filetype]) do
            if buftype == vim.bo.buftype then
              return
            end
          end
        end
        lint.try_lint()
        lint.try_lint({ "codespell" })
      end,
    })
  end,
}
