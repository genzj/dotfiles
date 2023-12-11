# dotfiles

This repo manages my dotfiles with [chezmoi](https://www.chezmoi.io/).

## Apply

1. [Install chezmoi](https://www.chezmoi.io/install/)
1. Apply the dotfiles by running `chezmoi init --apply genzj` [ref](https://www.chezmoi.io/reference/commands/init/)

## Managed Configurations

| App           | OS             | Platforms      | Notes          |
|-------------- | -------------- | -------------- | -------------- |
| Kitty         | MacOS          | x86-64         |                |
| Kitty         | Linux          | x86-64         | Arch           |
| Git           | MacOS/Linux    | All            | use data `proxy` to swith on/off git http proxy setting |
| Bat           | MacOS/Linux    | All            | contrast-enhanced theme (twodark-genzj), config |


## Planned Configurations

| App group     | OS             | Items                    | Notes          |
|-------------- | -------------- | ------------------------ | -------------- |
| Zsh           | MacOS/Linux    | zshrc, omz, p10k, 3rd plugins | take from MacOS |
| czg           |                | .config/.czrc            | OpenAI token needs encryption |
| neovide       |                | config                   |                |
| ptpython      |                | config                   | TBD            |

External repos:

* [Oh-my-fish config](https://github.com/genzj/my-omf-config)
* [NeoVIM config](https://github.com/genzj/mynvim)
* [Tmux config](https://github.com/genzj/tmux-myconf)
