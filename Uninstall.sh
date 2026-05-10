#!/data/data/com.termux/files/usr/bin/bash

RED='\033[91m'
GREEN='\033[92m'
CYAN='\033[96m'
YELLOW='\033[93m'
RESET='\033[0m'
BOLD='\033[1m'

clear_screen() {
    printf "\033[2J\033[1;1H"
}

uninstall_eshell() {
    clear_screen
    printf "${RED}${BOLD}════════════════════════════════════════════════${RESET}\n"
    printf "${RED}${BOLD}        ESHELL COMPLETE UNINSTALL${RESET}\n"
    printf "${RED}${BOLD}════════════════════════════════════════════════${RESET}\n\n"
    
    printf "${YELLOW}${BOLD}The following will be REMOVED:${RESET}\n\n"
    
    printf "${CYAN}📁 Core Files:${RESET}\n"
    printf "  • $HOME/eshell.py\n"
    printf "  • $HOME/eshell.sh\n"
    printf "  • $HOME/.eshell_pass\n"
    printf "  • $HOME/.eshell_logo.webp\n"
    printf "  • $HOME/.eshell_history\n"
    printf "  • $HOME/.eshell_aliases\n\n"
    
    printf "${CYAN}🗑️ Directories:${RESET}\n"
    printf "  • $HOME/.eshell_trash/\n"
    printf "  • $HOME/.eshell_backups/\n"
    printf "  • $HOME/.eshell_config/\n\n"
    
    printf "${CYAN}⚙️ Auto-start Configurations:${RESET}\n"
    printf "  • Lines from $HOME/.bashrc\n"
    printf "  • Lines from $HOME/.zshrc\n"
    printf "  • $HOME/.termux/boot/start-eshell\n\n"
    
    printf "${RED}${BOLD}⚠️  WARNING: This action is IRREVERSIBLE!${RESET}\n\n"
    printf "${YELLOW}Are you sure you want to completely uninstall Eshell? (type 'yes' to confirm): ${RESET}"
    read -r confirm
    
    if [ "$confirm" = "yes" ]; then
        printf "\n${CYAN}${BOLD}Uninstalling...${RESET}\n\n"
        
        printf "${GREEN}✓ Removing core files...${RESET}\n"
        rm -f "$HOME/eshell.py"
        rm -f "$HOME/eshell.sh"
        rm -f "$HOME/.eshell_pass"
        rm -f "$HOME/.eshell_logo.webp"
        rm -f "$HOME/.eshell_history"
        rm -f "$HOME/.eshell_aliases"
        
        printf "${GREEN}✓ Removing directories...${RESET}\n"
        rm -rf "$HOME/.eshell_trash"
        rm -rf "$HOME/.eshell_backups"
        rm -rf "$HOME/.eshell_config"
        
        printf "${GREEN}✓ Removing auto-start configurations...${RESET}\n"
        rm -f "$HOME/.termux/boot/start-eshell"
        
        if [ -f "$HOME/.bashrc" ]; then
            sed -i '/# Auto-launch Eshell/d' "$HOME/.bashrc"
            sed -i '/exec.*eshell.sh/d' "$HOME/.bashrc"
            sed -i '/exec.*eshell.py/d' "$HOME/.bashrc"
            printf "${GREEN}✓ Cleaned .bashrc${RESET}\n"
        fi
        
        if [ -f "$HOME/.zshrc" ]; then
            sed -i '/# Auto-launch Eshell/d' "$HOME/.zshrc"
            sed -i '/exec.*eshell.sh/d' "$HOME/.zshrc"
            sed -i '/exec.*eshell.py/d' "$HOME/.zshrc"
            printf "${GREEN}✓ Cleaned .zshrc${RESET}\n"
        fi
        
        printf "\n${GREEN}${BOLD}════════════════════════════════════════════════${RESET}\n"
        printf "${GREEN}${BOLD}✓ Eshell has been COMPLETELY removed from your device!${RESET}\n"
        printf "${GREEN}${BOLD}════════════════════════════════════════════════${RESET}\n\n"
        
        printf "${YELLOW}${BOLD}📌 Next Steps:${RESET}\n"
        printf "  1. Close all Termux sessions\n"
        printf "  2. Open a new Termux session\n"
        printf "  3. Your default shell will be restored\n\n"
        
        printf "${CYAN}Thank you for using Eshell! Goodbye.${RESET}\n"
    else
        printf "\n${GREEN}${BOLD}Uninstall cancelled. No files were removed.${RESET}\n"
    fi
}

uninstall_eshell
