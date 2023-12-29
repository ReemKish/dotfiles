local plugins = {
  "colorscheme"
, "devicons"
, "treesitter"
, "mason"
, "schemastore"
, "lspconfig"
, "navic"
, "breadcrumbs"
, "null-ls"
, "illuminate"
, "telescope"
, "telescope-tabs"
, "nvimtree"
, "lualine"
, "whichkey"
, "cmp"
, "autopairs"
, "comment"
, "gitsigns"
, "neogit"
, "diffview"
, "indentline"
, "alpha"
, "netrw"
, "project"
, "toggleterm"
, "bufdelete"
, "navigator"
}

for _, plugin in pairs(plugins) do
  spec("user.plugins." .. plugin)
end
