#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Constants
OMZ_DIR="$HOME/.oh-my-zsh"
CUSTOM_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/"
ZSHRC_BACKUP_DIR="$HOME/.zshrc.backup"
OMZ_INSTALL_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
PACKAGES=("zoxide" "fzf" "ripgrep" "bat" "eza")

# Helper functions
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Request sudo permission at the beginning
print_info "Requesting sudo permissions..."
sudo -v
if [ $? -ne 0 ]; then
    print_error "Failed to obtain sudo permissions. Exiting."
    exit 1
fi
print_success "Sudo permissions granted"

echo ""

# Backup current .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    BACKUP_FILE="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$HOME/.zshrc" "$BACKUP_FILE" || {
        print_error "Failed to backup existing .zshrc"
        exit 1
    }
    print_success "Backed up existing .zshrc to $BACKUP_FILE"
fi

# Install oh-my-zsh if not already installed
if [ ! -d "$OMZ_DIR" ]; then
    print_info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL $OMZ_INSTALL_URL)" "" --unattended || {
        print_error "Failed to install oh-my-zsh"
        exit 1
    }
    print_success "oh-my-zsh installed"
else
    print_info "oh-my-zsh is already installed"
fi

# Copy custom .zshrc
if [ -f "./.zshrc" ]; then
    cp "./.zshrc" "$HOME/.zshrc" || {
        print_error "Failed to copy .zshrc"
        exit 1
    }
    print_success "Copied Opinionated .zshrc"
else
    print_error ".zshrc file not found in current directory"
    exit 1
fi

# Copy all custom plugins
if [ -d "./plugins" ]; then
    mkdir -p "$CUSTOM_PLUGINS_DIR" || {
        print_error "Failed to create plugins directory"
        exit 1
    }

    mv "$CUSTOM_PLUGINS_DIR/plugins" "$CUSTOM_PLUGINS_DIR/plugins_backup" 2>/dev/null
    print_info "Made backup of current custom plugins dir"

    cp -r --no-preserve=mode ./plugins "$CUSTOM_PLUGINS_DIR" || {
        print_error "Failed to copy custom plugins"
        exit 1
    }
    print_success "Copied custom plugins"
else
    print_warning "./plugins directory not found"
fi

# Copy zsh_helpers
if [ -d "./zsh_helpers" ]; then
    ZSH_HELPERS_DIR="$HOME/.zsh_helpers"
    
    cp -r --no-preserve=mode ./zsh_helpers "$ZSH_HELPERS_DIR" || {
        print_error "Failed to copy zsh_helpers"
        exit 1
    }
    print_success "Copied zsh_helpers to $HOME"
else
    print_warning "./zsh_helpers directory not found"
fi

echo ""
print_info "Installing packages: ${PACKAGES[@]}"

# Install packages
for package in "${PACKAGES[@]}"; do
    sudo apt install -y "$package" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        print_success "Installed $package"
    else
        print_error "Failed to install $package"
    fi
done

echo ""
print_success "Installation complete!"
echo "------------------------"
print_info "Restart your shell for changes to apply"