
# 🔥 ESHELL - Ultimate Termux Shell

### Custom Shell for Android Termux with 50+ Exclusive Commands

<div align="center">
  <img src="https://img.shields.io/badge/Total%20Files-4-FF0000?style=for-the-badge">
  <img src="https://img.shields.io/badge/Dependencies-Low-00FF00?style=for-the-badge">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20Termux-FF6600?style=for-the-badge">
  <img src="https://img.shields.io/badge/Commands-50%2B-FF00FF?style=for-the-badge">
  
  [![Telegram](https://img.shields.io/badge/Telegram-@ERROR0101risback-26A5E4?style=for-the-badge&logo=telegram)](https://t.me/ERROR0101risback)
  [![GitHub](https://img.shields.io/badge/GitHub-ERROR0101r-181717?style=for-the-badge&logo=github)](https://github.com/ERROR0101r)
  
  <p><strong>Developer: @ERROR0101risback</strong></p>
  <p><em>No extra dependencies - Pure Python + Bash</em></p>
</div>

---

## 📋 WHAT IS ESHELL?

**Eshell** is a complete custom shell for Termux with password protection, custom themes, image logo, plugin system, and 50+ exclusive commands that don't exist in any other shell.

| # | File | Purpose | Status |
|---|------|---------|--------|
| 1 | **Setup.sh** | One-command installation | ✅ WORKING |
| 2 | **Uninstall.sh** | Complete removal | ✅ WORKING |
| 3 | **plugins.py** | Plugin management system | ✅ WORKING |
| 4 | **setup_autolaunch.sh** | Auto-start on Termux launch | ✅ WORKING |

---

## 🚀 COMPLETE INSTALLATION STEPS

### Step 1: Open Termux and Update

```bash
pkg update && pkg upgrade -y
```

Step 2: Install Dependencies

```bash
pkg install python git curl wget tar zip unzip termux-image-viewer -y
```

Step 3: Install Python Packages

```bash
pip install requests qrcode[pil] Pillow
```

Step 4: Clone Repository

```bash
git clone https://github.com/ERROR0101r/Eshell.git
```

Step 5: Enter Directory

```bash
cd Eshell
```

Step 6: Make Setup Executable

```bash
chmod +x Setup.sh
```

Step 7: Run Setup

```bash
bash Setup.sh
```

Step 8: Set Password (First Time Only)

```
First time setup! Create your password:
Enter new password: [type your password]
Confirm password: [type again]
✓ Password created successfully!
```

Step 9: Login

```
Enter password: [type your password]
✓ Access granted!
```

Step 10: Enable Auto-Launch (Optional)

```bash
bash setup_autolaunch.sh
```

---

🔥 EXCLUSIVE ESHELL COMMANDS

File Masters

Command Description
unpack <file> Extract ANY archive (zip, tar, gz, bz2, xz)
trash <file> Move to trash (safe delete)
undo Restore last trashed file
trash-list Show trash content
empty-trash Permanently clear trash
dupfind <dir> Find duplicate files by content
deadcode <dir> Find unused Python files
qfind <name> Super fast file search

Backup System

Command Description
backup <dir> Create timestamped backup
restore <file> Restore from backup

Network Power

Command Description
ports [count] Show free ports (8000-9000)
killport <port> Kill process using specific port
get <url> Download + auto-extract archives
serve [port] HTTP server with QR code

Dev Tools

Command Description
run <script> [--watch] Run Python with auto-restart
profile <script> Performance profiler
size <file> Show human-readable file size
tree [dir] Directory tree view
which <cmd> Show command location

Shell Control

Command Description
alias name=cmd Create permanent alias
unalias <name> Remove alias
path add <dir> Add directory to PATH
theme [cyan/red] Change colors instantly
reload Reload shell config
info Shell statistics
env Show environment variables
history Command history

Plugin Management

Command Description
plugin list Show all plugins
plugin install <name> Install new plugin
plugin remove <name> Remove plugin
plugin enable <name> Activate plugin
plugin disable <name> Deactivate plugin

Package Management

Command Description
pkg install <name> Install Termux package
pkg remove <name> Remove package
pkg list List all packages
pkg update Update packages
pkg search <query> Search packages

Basic Commands

Command Description
ls, cd, pwd, cat Navigation
mkdir, rm, cp, mv File operations
touch, head, tail File utilities
grep, find, clear Search & clear

---

🔌 HOW TO CREATE YOUR OWN PLUGIN

Step 1: Create Plugin File

Create file: ~/.eshell/plugins/myplugin.py

```python
def setup():
    return {
        'name': 'My Tools',
        'commands': {
            'hello': 'print("Hello from plugin")',
            'myip': 'import requests; print(requests.get("https://api.ipify.org").text)',
            'md5': 'import hashlib; print(hashlib.md5(open(args[0]).read()).hexdigest())'
        }
    }
```

Step 2: Install Plugin

```bash
plugin install myplugin
```

Step 3: Enable Plugin

```bash
plugin enable myplugin
```

Step 4: Use Commands

```bash
Eshell$ hello
Hello from plugin

Eshell$ myip
192.168.1.100

Eshell$ md5 file.txt
5d41402abc4b2a76b9719d911017c592
```

---

🎨 THEME COLORS

Command Effect
theme cyan Cyan prompt (default)
theme red Red prompt

---

📁 COMPLETE FILE STRUCTURE

```
Eshell/
├── Setup.sh                 # Main installer
├── Uninstall.sh             # Complete uninstaller
├── plugins.py               # Plugin manager
├── setup_autolaunch.sh      # Auto-launch config
│
├── ~/.eshell_pass           # Encrypted password
├── ~/.eshell_logo.webp      # Downloaded logo
├── ~/.eshell_history        # Command history
├── ~/.eshell_aliases        # Saved aliases
├── ~/.eshell_trash/         # Trash folder
├── ~/.eshell_backups/       # Backups folder
└── ~/.eshell/plugins/       # Plugins folder
```

---

❌ HOW TO UNINSTALL COMPLETELY

```bash
bash Uninstall.sh
# Type 'yes' when asked to confirm
```

---

⚠️ IMPORTANT DISCLAIMER

```
YOUR PASSWORD IS STORED AS A HASH. 
THERE IS NO WAY TO RECOVER IT IF YOU FORGET.

⚠️ IF YOU FORGET YOUR PASSWORD, YOU CANNOT LOGIN.
⚠️ THE ONLY SOLUTION IS TO COMPLETELY UNINSTALL AND REINSTALL.
⚠️ ALL YOUR SAVED DATA, ALIASES, AND BACKUPS WILL BE LOST.

✅ SAVE YOUR PASSWORD SOMEWHERE SAFE!
✅ USE A PASSWORD YOU WILL REMEMBER!
✅ DO NOT SHARE YOUR PASSWORD WITH ANYONE!
```

---

🔧 SYSTEM REQUIREMENTS

Requirement Minimum
Python 3.6+
RAM 256MB
Storage 50MB
Platform Android (Termux)

---

📞 DEVELOPER CONTACT

<div align="center">
  <p><strong>Name:</strong> ERROR</p>
  <p>
    <a href="https://t.me/ERROR0101risback">Telegram</a> •
    <a href="https://github.com/ERROR0101r">GitHub</a>
  </p>
  <p><strong>Email:</strong> t1342095@gmail.com</p>
</div>

---

🔗 REPOSITORY

· GitHub: https://github.com/ERROR0101r/Eshell

---

📜 LICENSE

```
Free to use, modify, and share.
Credit appreciated but not required.

© 2026 Eshell | Developed by ERROR
```

---

<div align="center">
  <h3>🔥 Install Eshell Today 🔥</h3>
  <p><i>No Bloat. No Extra Dependencies. Just Pure Power.</i></p>

  <p>
    <a href="https://t.me/ERROR0101risback"><img src="https://img.shields.io/badge/Telegram-@ERROR0101risback-26A5E4?style=flat-square&logo=telegram"></a>
    <a href="https://github.com/ERROR0101r"><img src="https://img.shields.io/badge/GitHub-ERROR0101r-181717?style=flat-square&logo=github"></a>
  </p>

  <p><strong>⭐ Star this repo if you find it useful! ⭐</strong></p>
</div>
