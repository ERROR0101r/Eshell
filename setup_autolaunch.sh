#!/usr/bin/env bash

# Eshell Auto-Launch Setup Script (FIXED)

RED='\033[91m'
GREEN='\033[92m'
CYAN='\033[96m'
RESET='\033[0m'

setup_autolaunch() {

    BASHRC="$HOME/.bashrc"
    ESHELL_MAIN="$HOME/eshell.py"

    echo -e "${CYAN}[*] Configuring Eshell auto-launch...${RESET}"

    # Check if eshell.py exists
    if [ ! -f "$ESHELL_MAIN" ]; then
        echo -e "${RED}[✗] eshell.py not found in HOME directory${RESET}"
        echo -e "${RED}Expected:${RESET} $HOME/eshell.py"
        exit 1
    fi

    # Create .bashrc if missing
    touch "$BASHRC"

    # Remove old broken launcher
    sed -i '/Setup.sh/d' "$BASHRC"

    # Add new launcher only if missing
    if ! grep -q "python ~/eshell.py" "$BASHRC"; then

        {
            echo ""
            echo "# ===== Eshell Auto Launch ====="

            # Prevent recursion
            echo 'if [ -z "$ESHELL_RUNNING" ]; then'
            echo 'export ESHELL_RUNNING=1'
            echo 'clear'
            echo 'python ~/eshell.py'
            echo 'fi'

        } >> "$BASHRC"

        echo -e "${GREEN}[✓] Auto-launch added successfully${RESET}"

    else
        echo -e "${CYAN}[!] Auto-launch already exists${RESET}"
    fi

    echo ""
    echo -e "${GREEN}[✓] Done! Restart Termux now.${RESET}"
}

setup_autolaunch