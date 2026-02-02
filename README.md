# EZSH - easy-sh

no-fuss easy install zsh with plugins (oh-my-zsh) and a couple of useful toolings  
config is opinionated yet open for configuration  

this is mainly for developers / engineers
wanting simple but better experiance in the terminal with minimal fuss  

currently only supports debian based distos

## install

clone repo then:
```bash
cd ezsh
./install.sh
```

## plugins

included:

- zsh-syntax-highlighting
- zsh-autosuggestions
- git
- zoxide
- colored-man-pages
- command-not-found
- you-should-use
- fzf-tab

might add later:

- dirhistory
- sudo
- zsh-bat
- extract
- history
- tmux

## adding plugins

If the plugin in included by default in oh-my-zsh  
then you can just add it to the plugins list in `.zshrc`

### custom plugins

1. clone repo to `/plugins`
2. remove the `.git/` directory from the plugins folder
3. add to plugins list in `.zshrc`

## adding helper scripts / alias scripts

Just add to the `/zsh_helpers` folder
