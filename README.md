# Osaka - Ops Swiss Army Knife

> :warning: This is a work in progress project a lot of things are missing here...

![logo](./assets/osaka.png)

`osaka` is meant to ease Ops teams daily tasks. It's a toolbox containing main Ops tools such as Ansible / Terraform / Hugo / Molecule. Each toolbox runs in a docker container.


## Installation

`osaka` comes as  ZSH plugin but it is not part of the official plugin list, so you need to install it manually:

* Edit your `~/.zshrc` and add `osaka` to the list of plugins to enable:

`plugins=( ... osaka )`

* In the command line, change to oh-my-zsh’s custom plugin directory and clone the repository:

`cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/Lowess/osaka osaka && cd && . ~/.zshrc`


## :package: Hugo

`osaka hugo <subcmd>`

## :package: Ansible

TODO

## :package: Molecule

TODO

## :package: Terraform

TODO
