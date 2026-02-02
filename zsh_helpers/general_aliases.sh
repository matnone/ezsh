# General useful aliases for developers

# Shortcuts
alias ..='cd ..'
alias cls='clear'
alias mkdir='mkdir -p'
alias h='_cat ~/.zsh_history | grep'

# Disk usage
alias du='du -h'        # human-readable
alias df='df -h'        # human-readable

# Process management
alias psg='ps aux | grep'  # search processes
alias k9='kill -9'         # force kill

# Network
alias ports='netstat -tulanp'  # show all open ports
