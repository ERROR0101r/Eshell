#!/data/data/com.termux/files/usr/bin/bash

# Eshell Auto-Launch Setup Script
# Runs Setup.sh every time Termux opens (which contains eshell.py inside it)

RED='\033[91m'
GREEN='\033[92m'
CYAN='\033[96m'
RESET='\033[0m'

setup_autolaunch() {
    BASHRC="$HOME/.bashrc"
    ESHELL_SETUP="$HOME/Eshell/Setup.sh"
    
    # Check if Setup.sh exists
    if [ ! -f "$ESHELL_SETUP" ]; then
        echo -e "${RED}✗ Setup.sh not found in ~/Eshell/${RESET}"
        exit 1
    fi
    
    # Add to .bashrc
    if [ -f "$BASHRC" ]; then
        if ! grep -q "Setup.sh" "$BASHRC"; then
            echo "" >> "$BASHRC"
            echo "# Auto-launch Eshell Setup" >> "$BASHRC"
            echo "cd ~/Eshell && bash Setup.sh" >> "$BASHRC"
            echo -e "${GREEN}✓ Added to .bashrc${RESET}"
        else
            echo -e "${CYAN}⚠ Auto-launch already configured${RESET}"
        fi
    fi
    
    echo ""
    echo -e "${GREEN}✓ Auto-launch configured! Restart Termux to see changes${RESET}"
}

setup_autolaunch