First, install Vim-Plug as the plugin manager for neovim
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
see: https://github.com/junegunn/vim-plug

# For iOS development

## Build server

See this post https://blog.akring.com/posts/make-swiftui--great-again-on-neovim/

and install

`brew install xcode-build-server`

## LSP

add this to :CocConfig file

found here https://github.com/neoclide/coc.nvim/wiki/Language-servers

"languageserver": {
  "swift": {
    "command": "sourcekit-lsp",
    "filetypes": ["swift"],
    "rootPatterns": ["Package.swift"]
  }
}
