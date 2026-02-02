# Opinionated Zsh Configuration
# ================================

# Path Configuration - Add user bin directories first
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell" # other recommended themes: bira, fino, awesomepanda

# for performance
zstyle ':omz:update' frequency 13

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

plugins=(
    fzf-tab # Fuzzy tab completion with preview - must be first!
    # git     # Git aliases (personally i dont like but you can uncomment if you want it)
    zsh-autosuggestions      # Command history suggestions
    zoxide  # Smart cd with frecency (initialized below)
    colored-man-pages        # Colored manual pages
    command-not-found        # Suggests packages for missing commands
    you-should-use           # Reminds of aliases you should be using

    # IF TYPING LAGS REMOVE THE FOLLOWING PLUGIN
    zsh-syntax-highlighting  # Syntax highlighting as you type
)

# Source oh-my-zsh
source "$ZSH/oh-my-zsh.sh"

# History Configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000

# Append to history instead of replacing
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# Avoid duplicate history entries
setopt HIST_IGNORE_DUPS       # Don't record consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS   # Remove duplicates when history is full
setopt HIST_FIND_NO_DUPS      # Don't show duplicates when searching
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space
setopt HIST_EXPIRE_DUPS_FIRST # Remove oldest duplicate first when trimming

# Shell Options
# Navigation - auto change directory and keep directory stack
setopt AUTO_CD              # cd into directory if command is a directory path
setopt AUTO_PUSHD           # Push directory onto stack when cd-ing
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates onto directory stack

# Spelling correction
setopt CORRECT              # Correct misspelled commands
#setopt CORRECT_ALL          # Correct all arguments, not just the command
setopt SHARE_HISTORY       # Share history across different shells

# Completion Options
setopt MENU_COMPLETE        # Auto-select first completion option
setopt COMPLETE_IN_WORD     # Complete within word boundaries

# Replaces cd with smart directory jumping based on frecency
eval "$(zoxide init --cmd cd zsh)"

# settings for extensions
export YSU_IGNORED_ALIASES=("g" "gra")
export ZSH_AUTOSUGGEST_USE_ASYNC=1
#ZSH_HIGHLIGHT_MAXLENGTH=300  # Don't highlight very long commands

# Source zsh helpers
if [ -d "$HOME/.zsh_helpers" ]; then
    for helper_file in "$HOME"/.zsh_helpers/*.sh; do
        [ -f "$helper_file" ] && source "$helper_file"
    done
fi
