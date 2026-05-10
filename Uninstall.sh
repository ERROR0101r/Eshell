#!/usr/bin/env bash

# ==========================================
#        ESHELL COMPLETE UNINSTALLER
# ==========================================

RED='\033[91m'
GREEN='\033[92m'
CYAN='\033[96m'
YELLOW='\033[93m'
RESET='\033[0m'
BOLD='\033[1m'

clear_screen() {
    printf "\033[2J\033[1;1H"
}

remove_from_file() {
    FILE="$1"

    [ ! -f "$FILE" ] && return

    sed -i.bak '/# Auto-launch Eshell/d' "$FILE"
    sed -i.bak '/python ~\/eshell.py/d' "$FILE"
    sed -i.bak '/bash ~\/Eshell\/start.sh/d' "$FILE"
    sed -i.bak '/exec.*eshell.py/d' "$FILE"
    sed -i.bak '/exec.*eshell.sh/d' "$FILE"
    sed -i.bak '/ESHELL_RUNNING/d' "$FILE"

    rm -f "${FILE}.bak"
}

uninstall_eshell() {

    clear_screen

    printf "${RED}${BOLD}════════════════════════════════════════════════${RESET}\n"
    printf "${RED}${BOLD}          ESHELL FULL UNINSTALLER${RESET}\n"
    printf "${RED}${BOLD}════════════════════════════════════════════════${RESET}\n\n"

    # Safety check
    if [ -z "$HOME" ]; then
        printf "${RED}[✗] HOME variable is empty. Aborting.${RESET}\n"
        exit 1
    fi

    printf "${YELLOW}${BOLD}The following will be removed:${RESET}\n\n"

    printf "${CYAN}📁 Core Files:${RESET}\n"
    printf "  • $HOME/eshell.py\n"
    printf "  • $HOME/eshell.sh\n"
    printf "  • $HOME/.eshell_pass\n"
    printf "  • $HOME/.eshell_logo.webp\n"
    printf "  • $HOME/.eshell_history\n"
    printf "  • $HOME/.eshell_aliases\n\n"

    printf "${CYAN}📂 Directories:${RESET}\n"
    printf "  • $HOME/.eshell_trash/\n"
    printf "  • $HOME/.eshell_backups/\n"
    printf "  • $HOME/.eshell_config/\n"
    printf "  • $HOME/.eshell/\n\n"

    printf "${CYAN}⚙️ Shell Config Cleanup:${RESET}\n"
    printf "  • .bashrc\n"
    printf "  • .bash_profile\n"
    printf "  • .profile\n"
    printf "  • .zshrc\n\n"

    printf "${CYAN}🚀 Boot Auto-start:${RESET}\n"
    printf "  • ~/.termux/boot/start-eshell\n\n"

    printf "${RED}${BOLD}⚠️ THIS ACTION CANNOT BE UNDONE!${RESET}\n\n"

    printf "${YELLOW}Type 'yes' to continue: ${RESET}"
    read -r confirm

    if [ "$confirm" != "yes" ]; then
        printf "\n${GREEN}Uninstall cancelled.${RESET}\n"
        exit 0
    fi

    printf "\n${CYAN}${BOLD}[*] Removing Eshell...${RESET}\n\n"

    # ==========================================
    # REMOVE CORE FILES
    # ==========================================

    printf "${GREEN}[✓] Removing core files...${RESET}\n"

    rm -f "$HOME/eshell.py"
    rm -f "$HOME/eshell.sh"

    rm -f "$HOME/.eshell_pass"
    rm -f "$HOME/.eshell_logo.webp"
    rm -f "$HOME/.eshell_history"
    rm -f "$HOME/.eshell_aliases"

    # ==========================================
    # REMOVE DIRECTORIES
    # ==========================================

    printf "${GREEN}[✓] Removing directories...${RESET}\n"

    rm -rf "$HOME/.eshell_trash"
    rm -rf "$HOME/.eshell_backups"
    rm -rf "$HOME/.eshell_config"
    rm -rf "$HOME/.eshell"

    # ==========================================
    # REMOVE BOOT FILES
    # ==========================================

    printf "${GREEN}[✓] Removing boot auto-start...${RESET}\n"

    rm -f "$HOME/.termux/boot/start-eshell"

    # ==========================================
    # CLEAN SHELL CONFIG FILES
    # ==========================================

    printf "${GREEN}[✓] Cleaning shell configs...${RESET}\n"

    remove_from_file "$HOME/.bashrc"
    remove_from_file "$HOME/.bash_profile"
    remove_from_file "$HOME/.profile"
    remove_from_file "$HOME/.zshrc"

    # ==========================================
    # OPTIONAL: REMOVE REPOSITORY
    # ==========================================

    if [ -d "$HOME/Eshell" ]; then
        printf "\n${YELLOW}Do you also want to remove the Eshell repository folder? (yes/no): ${RESET}"
        read -r repo_remove

        if [ "$repo_remove" = "yes" ]; then
            rm -rf "$HOME/Eshell"
            printf "${GREEN}[✓] Repository folder removed.${RESET}\n"
        fi
    fi

    # ==========================================
    # COMPLETE
    # ==========================================

    printf "\n${GREEN}${BOLD}════════════════════════════════════════════════${RESET}\n"
    printf "${GREEN}${BOLD}      ✓ ESHELL REMOVED SUCCESSFULLY ✓${RESET}\n"
    printf "${GREEN}${BOLD}════════════════════════════════════════════════${RESET}\n\n"

    printf "${CYAN}📌 Recommended:${RESET}\n"
    printf "  1. Close ALL Termux sessions\n"
    printf "  2. Reopen Termux\n"
    printf "  3. Default shell should return normally\n\n"

    printf "${CYAN}Goodbye 👋${RESET}\n"
}

uninstall_eshell