# Better modern CLI tools
# Prefixed with _ to access original commands if needed

alias cat='batcat'
alias _cat='/usr/bin/cat'

alias grep='rg'
alias _grep='/usr/bin/grep'

alias ls='eza'
alias _ls='/usr/bin/ls'

alias find='fdfind'
alias _find='/usr/bin/find'

# eza aliases
alias la='eza -ahl -s type'  # show hidden files
alias ll='eza -l -s type'    # long format
alias lt='eza -T -a'            # tree format

# batcat aliases  
alias bat='batcat'
alias _bat='/usr/bin/bat'

# fd aliases for common use cases
alias fd='fdfind'
alias fda='fdfind -H'        # include hidden files
alias fde='fdfind -e'        # search by extension: fde py

