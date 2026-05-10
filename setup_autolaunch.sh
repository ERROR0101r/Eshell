#!/data/data/com.termux/files/usr/bin/bash

# Eshell Auto-Launch Setup Script
# For Termux - Launches Eshell automatically on terminal start

RED='\033[91m'
GREEN='\033[92m'
CYAN='\033[96m'
YELLOW='\033[93m'
RESET='\033[0m'

clear_screen() {
    printf "\033[2J\033[1;1H"
}

print_banner() {
    clear_screen
    printf "${CYAN}════════════════════════════════════════════════${RESET}\n"
    printf "${CYAN}     ESHELL AUTO-LAUNCH SETUP${RESET}\n"
    printf "${CYAN}════════════════════════════════════════════════${RESET}\n\n"
}

setup_autolaunch() {
    BASHRC="$HOME/.bashrc"
    ZSHRC="$HOME/.zshrc"
    
    # Check if eshell.py exists (created by Setup.sh)
    if [ ! -f "$HOME/eshell.py" ]; then
        echo -e "${RED}✗ eshell.py not found! Please run Setup.sh first${RESET}"
        exit 1
    fi
    
    # Add to .bashrc
    if [ -f "$BASHRC" ]; then
        if ! grep -q "eshell.py" "$BASHRC"; then
            echo "" >> "$BASHRC"
            echo "# Auto-launch Eshell" >> "$BASHRC"
            echo "if [ -f \$HOME/eshell.py ]; then" >> "$BASHRC"
            echo "    cd \$HOME" >> "$BASHRC"
            echo "    python eshell.py" >> "$BASHRC"
            echo "fi" >> "$BASHRC"
            echo -e "${GREEN}✓ Added to .bashrc${RESET}"
        else
            echo -e "${YELLOW}⚠ Eshell already in .bashrc${RESET}"
        fi
    fi
    
    # Add to .zshrc
    if [ -f "$ZSHRC" ]; then
        if ! grep -q "eshell.py" "$ZSHRC"; then
            echo "" >> "$ZSHRC"
            echo "# Auto-launch Eshell" >> "$ZSHRC"
            echo "if [ -f \$HOME/eshell.py ]; then" >> "$ZSHRC"
            echo "    cd \$HOME" >> "$ZSHRC"
            echo "    python eshell.py" >> "$ZSHRC"
            echo "fi" >> "$ZSHRC"
            echo -e "${GREEN}✓ Added to .zshrc${RESET}"
        else
            echo -e "${YELLOW}⚠ Eshell already in .zshrc${RESET}"
        fi
    fi
    
    echo ""
    echo -e "${GREEN}════════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}✓ Auto-launch configured successfully!${RESET}"
    echo -e "${GREEN}════════════════════════════════════════════════${RESET}"
    echo ""
    echo -e "${YELLOW}Restart Termux to see changes${RESET}"
}

print_banner
setup_autolaunch