local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

vim.opt.completeopt = "menuone,noselect"

require("luasnip/loaders/from_vscode").lazy_load({ paths = {"~/.config/nvim/luasnip_snippets"}})
require("luasnip/loaders/from_snipmate").lazy_load({ paths = {"~/.config/nvim/snippets"}})

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text          = "",
    Method        = "",
    Function      = "",
    Constructor   = "",
    Field         = "ﰠ",
    Variable      = "",
    Class         = "ﴯ",
    Interface     = "",
    Module        = "",
    Property      = "ﰠ",
    Unit          = "塞",
    Value         = "",
    Enum          = "",
    Keyword       = "",
    Snippet       = "",
    Color         = "",
    File          = "",
    Reference     = "",
    Folder        = "",
    EnumMember    = "",
    Constant      = "",
    Struct        = "פּ",
    Event         = "",
    Operator      = "",
    TypeParameter = "",
    Table         = " ",
    Object        = "",
    Tag           = " ",
    Array         = " ",
    Boolean       = "蘒",
    Number        = "",
    String        = "",
    Calendar      = " ",
    Watch         = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(_, vim_item)
            -- Kind icons
            -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            return vim_item
        end,
    },
    sources = {
        { name = "copilot"      , group_index = 2 } ,
        { name = "cmp_tabnine"  , group_index = 2 } ,
        { name = "nvim_lsp"     , group_index = 2 } ,
        { name = "path"         , group_index = 2 } ,
        { name = "buffer"       , group_index = 2 } ,
        { name = "luasnip"      , group_index = 2 } ,
        { name = "neosnippet" } ,
    },
    confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
    },
    experimental = { ghost_text = true, native_menu = false },
})
