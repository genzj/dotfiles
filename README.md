# dotfiles

This repo manages my dotfiles with [chezmoi](https://www.chezmoi.io/).

## Apply

1. [Install chezmoi](https://www.chezmoi.io/install/)
1. Apply the dotfiles by running `chezmoi init --apply genzj` [ref](https://www.chezmoi.io/reference/commands/init/)

## Tools

1. [Install zim](https://zimfw.sh/docs/install/) or disable it by change config
    `data.tool.zsh.use_zim` to false. Following tools are recommended and
    integrated into the zim config:
    1. [Install starship](https://starship.rs/guide/#%F0%9F%9A%80-installation).
    1. [Install fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
    1. [Install zoxide](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation)
1. [Install mise](https://mise.jdx.dev/getting-started.html).

## Managed Configurations

| App           | OS             | Platforms      | Notes          |
|-------------- | -------------- | -------------- | -------------- |
| Kitty         | MacOS          | x86-64         |                |
| Kitty         | Linux          | x86-64         | Excl. CloudDesktop |
| Git           | MacOS/Linux    | All            | Use data `proxy` to swith on/off git http proxy setting |
| Bat           | MacOS/Linux    | All            | Contrast-enhanced theme (twodark-genzj), config |
| czg           | MacOS/Linux    | All            | Needs age key. Excl. CloudDesktop |
| tmux          | MacOS/Linux    | All            | Work with my tmux config and tpm (see External repos below) |
| zsh           | MacOS/Linux    | All            | Zim only |

External repos:

* [Tmux config](https://github.com/genzj/tmux-myconf)
* [Tmux plugin manager](https://github.com/tmux-plugins/tpm)
* [Oh-my-fish config](https://github.com/genzj/my-omf-config)
* ZimAmznDev (only on working environments)

## Planned Configurations

| App group     | OS             | Items                    | Notes          |
|-------------- | -------------- | ------------------------ | -------------- |
| ptpython      |                | config                   | TBD            |

## Other Planned Features

[ ] Install tools automatically

## Out of Scope (for now)

### NeoVIM and Neovide config

My [NeoVIM config](https://github.com/genzj/mynvim) contains the lazy lock file
which varies with different OS/host because not all plugins are enabled
everywhere. So chezmoi external system which is based on git-pull cannot always
successfully update the config folder which contains modified lazy-lock file.

Most of the Neovide customizations are also included in the mynvim repo as lua
scripts. Neovide [config file](https://neovide.dev/config-file.html) is for a
different set of configurations which I don't need to alter because their
default values works well for me. So it's not managed by this repo either.

## Troubleshooting

### `is-at-least` function error during `zimfw` execution

The function definition is missing in some "internal" patched zsh 5.x. Download
it from
[here](https://github.com/zsh-users/zsh/blob/master/Functions/Misc/is-at-least)
and put it under the system-level zsh function folder.
