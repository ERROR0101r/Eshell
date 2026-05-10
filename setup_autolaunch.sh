#!/data/data/com.termux/files/usr/bin/bash

# Auto-launch Eshell on Termux startup

ESHELL_SCRIPT="$HOME/eshell.sh"
BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"

# Create the main eshell launcher
cat > "$ESHELL_SCRIPT" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
cd "$HOME"
python "$HOME/eshell.py"
EOF

chmod +x "$ESHELL_SCRIPT"

# Add to .bashrc (if using bash)
if [ -f "$BASHRC" ]; then
    if ! grep -q "eshell.sh" "$BASHRC"; then
        echo "" >> "$BASHRC"
        echo "# Auto-launch Eshell" >> "$BASHRC"
        echo "if [ -f \$HOME/eshell.py ]; then" >> "$BASHRC"
        echo "    exec $HOME/eshell.sh" >> "$BASHRC"
        echo "fi" >> "$BASHRC"
    fi
fi

# Add to .zshrc (if using zsh)
if [ -f "$ZSHRC" ]; then
    if ! grep -q "eshell.sh" "$ZSHRC"; then
        echo "" >> "$ZSHRC"
        echo "# Auto-launch Eshell" >> "$ZSHRC"
        echo "if [ -f \$HOME/eshell.py ]; then" >> "$ZSHRC"
        echo "    exec $HOME/eshell.sh" >> "$ZSHRC"
        echo "fi" >> "$ZSHRC"
    fi
fi

# Create Termux startup script
TERMUX_BOOT="$HOME/.termux/boot"
mkdir -p "$TERMUX_BOOT"

cat > "$TERMUX_BOOT/start-eshell" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
sleep 2
exec $HOME/eshell.sh
EOF

chmod +x "$TERMUX_BOOT/start-eshell"

echo -e "\033[96mEshell auto-launch configured!\033[0m"
echo -e "\033[93mRestart Termux to see changes\033[0m"
