# Lougnar dotfiles

Your dotfiles are how you personalize your system. These are mine.  


# Configurations

Clone repo:
`git clone git@github.com:Lougnar/conf.git ~/.config`

## Windows

### fonts

Install FiraCode Nerd Font

copy - paste the font folder into `C:\Windows\Fonts`

### Powershell 7.4

Install: `winget install --id Microsoft.Powershell --source winget`

Get profile script path: `$profile`

Add path to our custom profile script in the default powershell profile:
`C:\Users\<User>\.config\powershell\profile.ps1`

Customize `.confg\powershell\profile.ps1` with your ownenv if needed

### Starship

`winget install --id Starship.Starship`

### Neovim

Install Neovim

`winget install Neovim.Neovim`

Install ripgrep (find directory with regexp, ignore etc..) & fd (find cmd alternative) for telescope plugin.

`winget install BurntSushi.ripgrep.MSVC`

Install find command

`winget install sharkdp.fd`

Install llvm & mysys2 environment for tree sitter parser compilaion
parser compiled with gcc crash neovim
https://github.com/nvim-treesitter/nvim-treesitter/issues/5264

`winget install llvm`
`winget install --id=MSYS2.MSYS2  -e`

Add clang to your path
`C:\Program Files\LLVM\bin`

## Git GUI terminal app
Install lazy git
`winget install -e --id=JesseDuffield.lazygit`
