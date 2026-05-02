return {
  -- Language server installer
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Bridge mason ↔ lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",        -- TypeScript / JavaScript
        "ruby_lsp",     -- Ruby
        "pyright",      -- Python
        "terraformls",  -- Terraform
        "jsonls",       -- JSON
      },
      automatic_installation = true,
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "ts_ls", "ruby_lsp", "pyright", "terraformls", "jsonls" }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({ capabilities = capabilities })
      end

      -- LSP keymaps (set when LSP attaches to a buffer)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local map = vim.keymap.set
          local opts = { buffer = ev.buf }
          map("n", "gd",          vim.lsp.buf.definition,    opts)
          map("n", "gr",          vim.lsp.buf.references,    opts)
          map("n", "gi",          vim.lsp.buf.implementation, opts)
          map("n", "K",           vim.lsp.buf.hover,         opts)
          map("n", "<leader>rn",  vim.lsp.buf.rename,        opts)
          map("n", "<leader>ca",  vim.lsp.buf.code_action,   opts)
          map("n", "[d",          vim.diagnostic.goto_prev,  opts)
          map("n", "]d",          vim.diagnostic.goto_next,  opts)
          map("n", "<leader>d",   vim.diagnostic.open_float, opts)
        end,
      })
    end,
  },

  -- Completion engine (replaces CoC completion)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"]   = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]   = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]   = cmp.mapping.abort(),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Formatting (replaces coc-prettier / coc-eslint formatting)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescript      = { "prettier" },
        typescriptreact = { "prettier" },
        css             = { "prettier" },
        markdown        = { "prettier" },
        json            = { "prettier" },
        ruby            = { "rubocop" },
        terraform       = { "terraform_fmt" },
      },
    },
  },
}
