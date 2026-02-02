# Developer productivity shortcuts

# Quick server
alias serve='python3 -m http.server'  # serve current dir on :8000

# Docker shortcuts (if docker is installed)
if command -v docker &> /dev/null; then
    alias dps='docker ps'
    alias di='docker images'
    alias dex='docker exec -it'
    alias dlog='docker logs -f'
fi

# Show disk usage of current dir sorted by size
alias ducks='du -cks * | sort -rn | head -11'

# Make and enter directory
mcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick find and edit
fe() {
    local file
    file=$(fdfind -H -t f | fzf --preview 'batcat --color=always {}')
    [ -n "$file" ] && ${EDITOR:-nano} "$file"
}

# Quick cd with fzf
fcd() {
    local dir
    dir=$(fdfind -H -t d | fzf)
    [ -n "$dir" ] && cd "$dir"
}
