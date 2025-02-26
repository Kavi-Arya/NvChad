dofile(vim.g.base46_cache .. "cmp")

local cmp = require "cmp"

local options = {
  completion = { completeopt = "menu,menuone" },
  -- completion = { completeopt = "noselect" },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),

    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif require("luasnip").expand_or_jumpable() then
    --     require("luasnip").expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  -- sources = {
  --   { name = "nvim_lsp" },
  --   { name = "luasnip" },
  --   { name = "buffer" },
  --   { name = "nvim_lua" },
  --   { name = "path" },
  --   { name = "spell" },
  -- },
  --
  sources = {
    { name = 'cmp_ai' },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "git" },
    -- { name = "codecompanion" },
    {
      name = 'look',
      keyword_length = 2,
      option = {
        convert_case = true,
        loud = true,
        dict = '/usr/share/dict/words'
      }
    },
    { name  = "codeium", priority = 10000000000 },
    {
      name = "spell",
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return true
        end,
        preselect_correct_word = true,
      },
    },
  },
}

return vim.tbl_deep_extend("force", options, require "nvchad.cmp")
