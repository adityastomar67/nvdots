<div align="center">
  <h2>Module: NVIM.</h1>
  Brief description of how this sub configuration actually works.
</div>

# Screenshots
### Dashboard using alpha.nvim
<img src="https://github.com/adityastomar67/nvim-dots/blob/main/bin/img/SS01.png"></img>

### Code Conceal
<img src="https://github.com/adityastomar67/nvim-dots/blob/main/bin/img/SS02.png"></img>

### When code conceal is off
<img src="https://github.com/adityastomar67/nvim-dots/blob/main/bin/img/SS03.png"></img>

### LimeLight for Better focusing
<img src="https://github.com/adityastomar67/nvim-dots/blob/main/bin/img/SS04.png"></img>

### File Browsing with nvim-tree and Telescope file_browser extension
<img src="https://github.com/adityastomar67/nvim-dots/blob/main/bin/img/SS05.png"></img>

#### Before we proceed, File Structure is like

If the reader is well versed or, has a general experience with shell scripting, Lua language or, know what they are doing then they may skip this section. But it advised to take a good understanding of the file structure before making any changes.

```
nvim
├── after
│   ├── queries
│   │   ├── cpp
│   │   │   └── highlights.scm
│   │   ├── lua
│   │   │   └── highlights.scm
│   │   └── python
│   │       └── highlights.scm
│   └── syntax
│       ├── go.vim
│       ├── html.vim
│       ├── javascript.vim
│       ├── markdown.vim
│       ├── python.vim
│       ├── ruby.vim
│       ├── rust.vim
│       └── xml.vim
├── bin
├── init.lua
├── lua
│   └── core
│       ├── alpha.lua
│       ├── cmds.lua
│       ├── cmp.lua
│       ├── colorscheme.lua
│       ├── comment.lua
│       ├── consts.lua
│       ├── dressing.lua
│       ├── files.lua
│       ├── gitsigns.lua
│       ├── keymaps.lua
│       ├── lspInstaller.lua
│       ├── lsp.lua
│       ├── lsp-saga.lua
│       ├── null-ls.lua
│       ├── nvim-tree.lua
│       ├── options.lua
│       ├── plugins.lua
│       ├── shared
│       │   └── ascii_art.lua
│       ├── telescope.lua
│       ├── todo.lua
│       ├── toggleterm.lua
│       ├── treesitter.lua
│       └── utils.lua
└── snippets
```


## Install language servers

Most available via npm

```bash
npm install -g typescript typescript-language-server vscode-langservers-extracted vls @tailwindcss/language-server yaml-language-server @prisma/language-server emmet-ls neovim graphql-language-service-cli graphql-language-service-server @astrojs/language-server bash-language-server

```

> TIP: [No sudo on global npm install](https://github.com/sindresorhus/guides/blob/main/npm-global-without-sudo.md)

### Lua, Pyright, Deno, Gopls and rust-analyzer available in Arch/Manjaro repos

Check your package manager for availability if not on an Arch based distro -
_brew, apt_ etc.

```bash
sudo pacman -S lua-language-server pyright deno rust-analyzer gopls shellcheck
```

## Install formatters

[ prettier ](https://prettier.io/) with npm

```bash
npm i -g prettier
```

[ shfmt ](https://github.com/mvdan/sh) is in the AUR

```bash
sudo pacman -S shfmt
```

[ stylua ](https://github.com/JohnnyMorganz/StyLua) is in the AUR

```bash
sudo pacman -S stylua
```

Check your package manager for availability if not on an Arch based distro -
_brew, apt_ etc.

[autopep8](https://pypi.org/project/autopep8/) for python is in Manjaro/Arch
repos

```bash
sudo pacman -S autopep8
```

Check your package manager for availability if not on an Arch based distro -
_brew, apt_ etc.

[yamlfmt](https://pypi.org/project/yamlfmt/) for yaml available with pip

```bash
sudo pip install yamlfmt
```

# Installation

```bash
  # move to home dir
  cd ~
  # back up current config
  cp -r ~/.config/nvim ~/.config/nvim.backup
  # clone repository
  git clone https://github.com/adityastomar67/nvim-dots.git ~/.config
  # Launch nvim for the first time with this command to install plugins
  nvim +PackerInstall
  # exit nvim and Then compile the loader file
  nvim +PackerCompile
```

### Additionals
## Note: Installing Firenvim

Run this command in nvim to install FireNvim in your browser.

```
:call firenvim#install(0)
```

or install the [FireFox extension](https://addons.mozilla.org/en-GB/firefox/addon/firenvim/)
or the [Chrome extension](https://chrome.google.com/webstore/detail/firenvim/egpjdkipkomnmjhjmdamaniclmdlobbo?hl=en)

## Adding custom Snippets

The conifg uses [ luasnip ](https://github.com/saadparwaiz1/cmp_luasnip) paired
with [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) for VS Code style snippets.
You can add your own snippets to the config [ snippets directory ](./snippets).
You'll also need to edit the [snippets/package.json](./snippets/package.json) to
be able to load your snippets in the correct filetype.
One test snippet is included as an example.

## Currently installed plugins

1. [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim) - Plugin manager
2. [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP
3. [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy find anything
4. [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) Language parsing for highlighting and more
5. [hoob3rt/lualine.nvim](https://github.com/hoob3rt/lualine.nvim) Status line
6. [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) Icons
7. [glacambre/firenvim](https://github.com/glacambre/firenvim) Embed nvim in firefox or chrome
8. [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) Auto completions, suggestions and imports

   Source completion includes:
   - [ hrsh7th/cmp-cmdline ](https://github.com/hrsh7th/cmp-cmdline) command line
   - [ hrsh7th/cmp-buffer ](https://github.com/hrsh7th/cmp-buffer) buffer completions
   - [ hrsh7th/cmp-nvim-lua ](https://github.com/hrsh7th/cmp-nvim-lua) nvim config completions
   - [ hrsh7th/cmp-nvim-lsp ](https://github.com/hrsh7th/cmp-nvim-lsp) lsp completions
   - [ hrsh7th/cmp-path ](https://github.com/hrsh7th/cmp-path) file path completions
   - [ saadparwaiz1/cmp_luasnip ](https://github.com/saadparwaiz1/cmp_luasnip) snippets completions
   - [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) Snippets
   - [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)

9. [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) Git tools
10. [tpope/vim-surround](https://github.com/tpope/vim-surround) Surroundings
    pairs mappings
11. [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) Vim style
    commenting
12. [knubie/vim-kitty-navigator](https://github.com/knubie/vim-kitty-navigator)
    Move between Nvim and Kitty splits
13. [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) HTML/JSX
    auto tags
14. [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) Auto bracket
    and quote pairs
15. [windwp/nvim-spectre](https://github.com/windwp/nvim-spectre) Project wide
    find and replace
16. [mhartington/formatter.nvim](https://github.com/mhartington/formatter.nvim)
    Formatting
17. [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter) Git status
    in the sign column
18. [leafOfTree/vim-matchtag](https://github.com/leafOfTree/vim-matchtag)
    Highlight matching tag in HTML/JSX
19. [phaazon/hop.nvim](https://github.com/phaazon/hop.nvim) Jump anywhwere in
    your code
20. [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) File
    tree
21. [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) Better commenting based on file type
22. [onsails/lspkind-nvim](https://github.com/onsails/lspkind-nvim) Icons in
    completion
23. [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) Theme
24. [folke/trouble.nvim](https://github.com/folke/trouble.nvim) Show the problems
    in your code
25. [folke/which-key.nvim](https://github.com/folke/which-key.nvim) Keymap helper
26. [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
    Highlight and search project todos and notes
27. [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)
    Display the colour of your hex/rgb/hsl value
28. [kevinoid/vim-jsonc](https://github.com/kevinoid/vim-jsonc) Comments in json
    filetype
29. [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) Buffers
    in tabs
30. [weilbith/nvim-code-action-menu](https://github.com/ahmedkhalf/weilbith/nvim-code-action-menu) Better code actions
31. [delphinus/vim-firestore](https://github.com/delphinus/vim-firestore) Syntax
    highlighting and completion for Firebase rules
32. [rmagatti/auto-session](https://github.com/rmagatti/auto-session) Session
    management
33. [andweeb/presence.nvim](https://github.com/andweeb/presence.nvim) Rich
    presence in Discord
34. [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) Dashboard
35. [mbbill/undotree](https://github.com/mbbill/undotree) Undotree

## Resources and inspiration

[Nvim Lua guide](https://github.com/nanotee/nvim-lua-guide)

[Ben Frain has a nice setup](https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f)

[Lunar Vim for inspiration](https://github.com/ChristianChiarulli/LunarVim)

[Ui Customization docs](https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter)

[Lua for Programmers](https://ebens.me/post/lua-for-programmers-part-1/)

[LSP config](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

[Awesome list of plugins](https://github.com/rockerBOO/awesome-neovim)

[Plugin Finder](https://neovimcraft.com/)
Noting really, if you have (Neo)vim installed then you can just backup your previous config if any, then just clone this repo and create a symlink of this configuration to your ~/.config/nvim

**SUGGESTION**

* Font: Operator Mono
* [dot_files](https://github.com/adityastomar67/.dotfiles/)
