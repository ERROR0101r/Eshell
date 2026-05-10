#!/data/data/com.termux/files/usr/bin/bash

ESHELL_PATH="$HOME/eshell.py"
PASSWORD_FILE="$HOME/.eshell_pass"
MAX_ATTEMPTS=3

RED='\033[91m'
GREEN='\033[92m'
CYAN='\033[96m'
YELLOW='\033[93m'
RESET='\033[0m'
BOLD='\033[1m'

clear_screen() {
    printf "\033[2J\033[1;1H"
}

print_banner() {
    clear_screen
    printf "${CYAN}"
    printf "8..   .-+**+=-:..        ..:-=+**+-.   ..\n"
    printf "        ..  .=**+-.        ......        .-+**=.  ..\n"
    printf "       .  :+#+:    ......................    :+#+:  .\n"
    printf "     .  :*#=.   ...  ...            ...  ...   .=#*: ..\n"
    printf "    .  +#=.    .  ..     ..........     .   .    .=#+  .\n"
    printf "   . :#*.   :+=...  ....::::::::::::....  ..:=+:   .*#: .\n"
    printf "  . -%= .::#@+.   .::..::..:.:..:..::..::.   .*@#::. =%- .\n"
    printf " . =@: =#=@%+   .:::..:.  :. :. .:  .:..:::.  .+%@=#= :@- .\n"
    printf ". -@:.-@==**+..::.  ::..::::==++-:::..::  .::..+**=+@-.:@: .\n"
    printf "..@--+*@=##+ .:.  ..:    :.:%--@#.:   .:..  .:..+##=@**:-@..\n"
    printf " ** @*+@#*- .-... .:.   .:.  :*+..:.   .:. ...-. -*#@+*@ **\n"
    printf ":@.:@#=+*#:.:..::.::.....:...--  .:.....::.::..:.:%*+=#@:.@:\n"
    printf "** -@#-@%: :.   ..:.....:::::##:::::.....:..   .: -@@-%@: #+\n"
    printf "%-==+@@*-..: . . .:     ::  .--.  ::     :.   . :..-*@@+=-=%\n"
    printf "@:+%.@=-%..:......:...  ..::=##=::..  ...:......:..%-+%.%=:@\n"
    printf "@.-@*:=@+ ::.:::.::..::-+#%.:%%:.@#=-::..::.:::.:: +@=:*@::@\n"
    printf "@: #@=@%:..: . . .:*%%@@@@+ .*+. *@@@@%%*:. . . :..:@%=@# -@\n"
    printf "%---#@@-+-.: ..   =@@@@@@@+ .%%. *@@@@@@@=   .. :.=+=@@*--=%\n"
    printf "**-@-=@:@* :.   ..*@@@@@@@@..@@.:@@@@@@@@*..   .: #%:@=-@-*+\n"
    printf ":@.*@*--@#:.:..::.%@@@@@@@@#:@@:%@@@@@@@@#.::..:.:#@-=*@+.@:\n"
    printf " ** =@@+%#-*.:.. .@@@@@@@@@@@@@@@@@@@@@@@@. ..:.*-%%+@@= #*\n"
    printf "..@-:++#%@:@#.:..-@@@@@@@@@@@@@@@@@@@@@@@@-..:.#%:@%#++:-%..\n"
    printf ". -@:+#==*=+@+.:.+@@@@@@@@@@@@@@@@@@@@@@@@=.:.+@==+==#+:@: .\n"
    printf " . -%:-%@#*=#@-*=*@@@@@@@@@@@@@@@@@@@@@@@@*=*=@#=*#@%-:%- .\n"
    printf "  . -%- -#%%#@%=@@@@@@@@@@@@@@@@@@@@@@@@@@@%=%%#%%#- =%- .\n"
    printf "   . :#*.:++++*+-#@@@@@@@@@@@@@@@@@@@@@@@@*-+*++++:.*#: .\n"
    printf "    .  +#=:=*%%%%###**@@@@@@@@@@@@@@@@**###%%%%*=:=#+  .\n"
    printf "     .. :*#-.:=+++++#%@@@@@@@@@@@@@@@@%*+++++=:.=#*. ..\n"
    printf "       .  :+#+-=+*#%#*@@@@@@@@@@@@@@@@*#%#*+--+#+:  .\n"
    printf "        ..  .=+*=-.  :@@@@@@@@@@@@@@@@:  .-=*+-.  ..\n"
    printf "          ..   .-+**+#@@@@@@@@@@@@@@@@*+**+-.   ..\n"
    printf "            ...    .-=+*#%@@@@@@@@%#*+=-.    ...\n"
    printf "============================================================\n"
    printf "${RESET}"
    printf "${BOLD}${CYAN}Eshell v3.0 - Developed by ${RED}ERROR${RESET}\n"
    printf "${CYAN}============================================================${RESET}\n\n"
}

setup_password() {
    if [ ! -f "$PASSWORD_FILE" ]; then
        printf "${YELLOW}First time setup! Create your password:${RESET}\n"
        printf "${CYAN}Enter new password: ${RESET}"
        read -s pass1
        printf "\n${CYAN}Confirm password: ${RESET}"
        read -s pass2
        printf "\n"
        
        if [ "$pass1" = "$pass2" ] && [ -n "$pass1" ]; then
            echo -n "$pass1" | sha256sum | cut -d' ' -f1 > "$PASSWORD_FILE"
            printf "${GREEN}Password created successfully!${RESET}\n"
            sleep 1
            return 0
        else
            printf "${RED}Passwords do not match or empty!${RESET}\n"
            exit 1
        fi
    fi
    return 0
}

verify_password() {
    local attempt=1
    while [ $attempt -le $MAX_ATTEMPTS ]; do
        printf "${CYAN}Enter password: ${RESET}"
        read -s user_pass
        printf "\n"
        
        user_hash=$(echo -n "$user_pass" | sha256sum | cut -d' ' -f1)
        stored_hash=$(cat "$PASSWORD_FILE")
        
        if [ "$user_hash" = "$stored_hash" ]; then
            printf "${GREEN}Access granted!${RESET}\n"
            sleep 0.5
            return 0
        else
            printf "${RED}Wrong password! (Attempt $attempt/$MAX_ATTEMPTS)${RESET}\n"
            attempt=$((attempt + 1))
        fi
    done
    
    printf "${RED}${BOLD}Too many failed attempts! Exiting...${RESET}\n"
    sleep 2
    exit 1
}

check_and_create_eshell() {
    if [ ! -f "$ESHELL_PATH" ]; then
        printf "${YELLOW}Creating eshell.py...${RESET}\n"
        cat > "$ESHELL_PATH" << 'EOF'
#!/usr/bin/env python3
import os
import sys
import subprocess
import readline
import requests
import shutil
import time
import hashlib
import threading
import socket
from pathlib import Path
from datetime import datetime

os.environ['PYTHONSTARTUP'] = ''
readline.parse_and_bind('tab: complete')

class Eshell:
    def __init__(self):
        self.cyan = "\033[96m"
        self.red = "\033[91m"
        self.reset = "\033[0m"
        self.logo_path = os.path.expanduser("~/.eshell_logo.webp")
        self.history_file = os.path.expanduser("~/.eshell_history")
        self.trash_dir = os.path.expanduser("~/.eshell_trash")
        self.backup_dir = os.path.expanduser("~/.eshell_backups")
        self.aliases = {}
        self.path_dirs = []
        
        for d in [self.trash_dir, self.backup_dir]:
            if not os.path.exists(d):
                os.makedirs(d)
        
        if os.path.exists(self.history_file):
            try:
                readline.read_history_file(self.history_file)
            except:
                pass
        
        self.download_logo()
        self.load_aliases()
    
    def load_aliases(self):
        alias_file = os.path.expanduser("~/.eshell_aliases")
        if os.path.exists(alias_file):
            try:
                with open(alias_file, 'r') as f:
                    for line in f:
                        if '=' in line:
                            k, v = line.strip().split('=', 1)
                            self.aliases[k] = v
            except:
                pass
    
    def save_aliases(self):
        alias_file = os.path.expanduser("~/.eshell_aliases")
        try:
            with open(alias_file, 'w') as f:
                for k, v in self.aliases.items():
                    f.write(f"{k}={v}\n")
        except:
            pass
    
    def download_logo(self):
        if not os.path.exists(self.logo_path):
            try:
                url = "https://iili.io/BDRPUla.webp"
                response = requests.get(url, timeout=5)
                with open(self.logo_path, 'wb') as f:
                    f.write(response.content)
            except:
                pass
        self.display_logo()
    
    def display_logo(self):
        os.system('clear')
        if os.path.exists(self.logo_path):
            try:
                subprocess.run(['termux-image-viewer', self.logo_path], timeout=2, capture_output=True)
            except:
                self.print_ascii_logo()
        else:
            self.print_ascii_logo()
        
        print(f"\n{self.cyan}{'='*50}{self.reset}")
        print(f"{self.cyan}Eshell v3.0 - Developed by {self.red}ERROR{self.reset}")
        print(f"{self.cyan}{'='*50}{self.reset}\n")
    
    def print_ascii_logo(self):
        logo = f"""
{self.cyan}8..   .-+**+=-:..        ..:-=+**+-.   ..
        ..  .=**+-.        ......        .-+**=.  ..
       .  :+#+:    ......................    :+#+:  .
     .  :*#=.   ...  ...            ...  ...   .=#*: ..
    .  +#=.    .  ..     ..........     .   .    .=#+  .
   . :#*.   :+=...  ....::::::::::::....  ..:=+:   .*#: .
  . -%= .::#@+.   .::..::..:.:..:..::..::.   .*@#::. =%- .
 . =@: =#=@%+   .:::..:.  :. :. .:  .:..:::.  .+%@=#= :@- .
. -@:.-@==**+..::.  ::..::::==++-:::..::  .::..+**=+@-.:@: .
..@--+*@=##+ .:.  ..:    :.:%--@#.:   .:..  .:..+##=@**:-@..
 ** @*+@#*- .-... .:.   .:.  :*+..:.   .:. ...-. -*#@+*@ **
:@.:@#=+*#:.:..::.::.....:...--  .:.....::.::..:.:%*+=#@:.@:
** -@#-@%: :.   ..:.....:::::##:::::.....:..   .: -@@-%@: #+
%-==+@@*-..: . . .:     ::  .--.  ::     :.   . :..-*@@+=-=%
@:+%.@=-%..:......:...  ..::=##=::..  ...:......:..%-+%.%=:@
@.-@*:=@+ ::.:::.::..::-+#%.:%%:.@#=-::..::.:::.:: +@=:*@::@
@: #@=@%:..: . . .:*%%@@@@+ .*+. *@@@@%%*:. . . :..:@%=@# -@
%---#@@-+-.: ..   =@@@@@@@+ .%%. *@@@@@@@=   .. :.=+=@@*--=%
**-@-=@:@* :.   ..*@@@@@@@@..@@.:@@@@@@@@*..   .: #%:@=-@-*+
:@.*@*--@#:.:..::.%@@@@@@@@#:@@:%@@@@@@@@#.::..:.:#@-=*@+.@:
 ** =@@+%#-*.:.. .@@@@@@@@@@@@@@@@@@@@@@@@. ..:.*-%%+@@= #*
..@-:++#%@:@#.:..-@@@@@@@@@@@@@@@@@@@@@@@@-..:.#%:@%#++:-%..
. -@:+#==*=+@+.:.+@@@@@@@@@@@@@@@@@@@@@@@@=.:.+@==+==#+:@: .
 . -%:-%@#*=#@-*=*@@@@@@@@@@@@@@@@@@@@@@@@*=*=@#=*#@%-:%- .
  . -%- -#%%#@%=@@@@@@@@@@@@@@@@@@@@@@@@@@@%=%%#%%#- =%- .
   . :#*.:++++*+-#@@@@@@@@@@@@@@@@@@@@@@@@*-+*++++:.*#: .
    .  +#=:=*%%%%###**@@@@@@@@@@@@@@@@**###%%%%*=:=#+  .
     .. :*#-.:=+++++#%@@@@@@@@@@@@@@@@%*+++++=:.=#*. ..
       .  :+#+-=+*#%#*@@@@@@@@@@@@@@@@*#%#*+--+#+:  .
        ..  .=+*=-.  :@@@@@@@@@@@@@@@@:  .-=*+-.  ..
          ..   .-+**+#@@@@@@@@@@@@@@@@*+**+-.   ..
            ...    .-=+*#%@@@@@@@@%#*+=-.    ...
============================================================{self.reset}
"""
        print(logo)
    
    def get_prompt(self):
        cwd = os.getcwd().replace(os.path.expanduser("~"), "~")
        if len(cwd) > 40:
            cwd = "..." + cwd[-37:]
        return f"{self.cyan}[{self.red}Eshell{self.cyan}][{cwd}]{self.reset}\n└─{self.red}${self.reset} "
    
    def execute(self, cmd):
        if not cmd.strip():
            return True
        
        readline.write_history_file(self.history_file)
        
        parts = cmd.strip().split()
        base = parts[0]
        args = parts[1:]
        
        if base in self.aliases:
            cmd = self.aliases[base] + ' ' + ' '.join(args)
            parts = cmd.strip().split()
            base = parts[0]
            args = parts[1:]
        
        if base in ['quit', 'exit']:
            return False
        
        elif base in ['help', '?']:
            self.show_help()
        
        elif base == 'clear':
            os.system('clear')
            self.display_logo()
        
        elif base == 'cd':
            try:
                target = args[0] if args else str(Path.home())
                os.chdir(target)
            except:
                print(f"{self.red}Error: Cannot cd to {args[0] if args else '~'}{self.reset}")
        
        elif base == 'pwd':
            print(os.getcwd())
        
        elif base == 'ls':
            try:
                path = args[0] if args else '.'
                for f in sorted(os.listdir(path)):
                    fp = os.path.join(path, f)
                    if os.path.isdir(fp):
                        print(f"{self.cyan}{f}/{self.reset}")
                    elif os.access(fp, os.X_OK):
                        print(f"{self.green}{f}{self.reset}")
                    else:
                        print(f)
            except:
                print(f"{self.red}Error listing{self.reset}")
        
        elif base == 'cat':
            if not args:
                print(f"{self.red}Usage: cat <file>{self.reset}")
            else:
                try:
                    with open(args[0], 'r') as f:
                        print(f.read())
                except:
                    print(f"{self.red}Cannot read file{self.reset}")
        
        elif base == 'mkdir':
            if args:
                os.makedirs(args[0], exist_ok=True)
        
        elif base == 'rm':
            if args:
                try:
                    path = args[0]
                    if os.path.isdir(path):
                        shutil.rmtree(path)
                    else:
                        os.remove(path)
                except:
                    print(f"{self.red}Cannot remove{self.reset}")
        
        elif base == 'cp':
            if len(args) >= 2:
                shutil.copy2(args[0], args[1])
        
        elif base == 'mv':
            if len(args) >= 2:
                shutil.move(args[0], args[1])
        
        elif base == 'touch':
            if args:
                Path(args[0]).touch()
        
        elif base == 'head':
            if args:
                try:
                    with open(args[0], 'r') as f:
                        lines = f.readlines()[:10]
                        print(''.join(lines))
                except:
                    print(f"{self.red}Cannot read file{self.reset}")
        
        elif base == 'tail':
            if args:
                try:
                    with open(args[0], 'r') as f:
                        lines = f.readlines()[-10:]
                        print(''.join(lines))
                except:
                    print(f"{self.red}Cannot read file{self.reset}")
        
        elif base == 'grep':
            if len(args) >= 2:
                try:
                    with open(args[1], 'r') as f:
                        for line in f:
                            if args[0] in line:
                                print(line.rstrip())
                except:
                    print(f"{self.red}Error searching{self.reset}")
        
        elif base == 'find':
            if args:
                for root, dirs, files in os.walk('.'):
                    for f in files + dirs:
                        if args[0] in f:
                            print(os.path.join(root, f))
        
        elif base == 'pkg':
            if args:
                subprocess.run(['pkg'] + args)
            else:
                print(f"{self.red}Usage: pkg [install|remove|list|update|search]{self.reset}")
        
        elif base == 'download':
            if args:
                try:
                    url = args[0]
                    name = args[1] if len(args) > 1 else url.split('/')[-1]
                    print(f"{self.cyan}Downloading...{self.reset}")
                    r = requests.get(url, stream=True)
                    total = int(r.headers.get('content-length', 0))
                    downloaded = 0
                    with open(name, 'wb') as f:
                        for chunk in r.iter_content(8192):
                            f.write(chunk)
                            downloaded += len(chunk)
                            if total > 0:
                                percent = (downloaded/total)*100
                                print(f"\r{self.cyan}Progress: {percent:.1f}%{self.reset}", end='')
                    print(f"\n{self.cyan}Saved: {name}{self.reset}")
                except:
                    print(f"{self.red}Download failed{self.reset}")
        
        elif base == 'unpack':
            if not args:
                print(f"{self.red}Usage: unpack <file>{self.reset}")
            else:
                archive = args[0]
                print(f"{self.cyan}Extracting...{self.reset}")
                if archive.endswith(('.tar.gz', '.tgz')):
                    subprocess.run(['tar', '-xzf', archive])
                elif archive.endswith('.tar.bz2'):
                    subprocess.run(['tar', '-xjf', archive])
                elif archive.endswith('.tar.xz'):
                    subprocess.run(['tar', '-xJf', archive])
                elif archive.endswith('.tar'):
                    subprocess.run(['tar', '-xf', archive])
                elif archive.endswith('.zip'):
                    subprocess.run(['unzip', '-q', archive])
                else:
                    print(f"{self.red}Unsupported format{self.reset}")
                print(f"{self.cyan}Extracted{self.reset}")
        
        elif base == 'backup':
            if not args:
                print(f"{self.red}Usage: backup <directory>{self.reset}")
            else:
                name = f"{args[0]}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.tar.gz"
                path = os.path.join(self.backup_dir, name)
                subprocess.run(['tar', '-czf', path, args[0]])
                print(f"{self.cyan}Backup saved: {path}{self.reset}")
        
        elif base == 'restore':
            if not args:
                print(f"{self.red}Usage: restore <backup_file>{self.reset}")
            else:
                subprocess.run(['tar', '-xzf', args[0]])
                print(f"{self.cyan}Restored{self.reset}")
        
        elif base == 'serve':
            port = int(args[0]) if args else 8000
            print(f"{self.cyan}Server at http://localhost:{port}{self.reset}")
            
            def show_qr():
                time.sleep(1)
                try:
                    import qrcode
                    qr = qrcode.make(f"http://localhost:{port}")
                    qr.print_tty()
                except:
                    pass
            
            threading.Thread(target=show_qr, daemon=True).start()
            subprocess.run(['python', '-m', 'http.server', str(port)])
        
        elif base == 'qfind':
            if not args:
                print(f"{self.red}Usage: qfind <name>{self.reset}")
            else:
                found = []
                for root, dirs, files in os.walk('.'):
                    for f in files:
                        if args[0].lower() in f.lower():
                            found.append(os.path.join(root, f))
                for f in found[:20]:
                    print(f)
                if len(found) > 20:
                    print(f"{self.cyan}... and {len(found)-20} more{self.reset}")
        
        elif base == 'trash':
            if args:
                dest = os.path.join(self.trash_dir, os.path.basename(args[0]))
                shutil.move(args[0], dest)
                print(f"{self.cyan}Moved to trash: {args[0]}{self.reset}")
        
        elif base == 'undo':
            trash_files = sorted(os.listdir(self.trash_dir), key=lambda x: os.path.getmtime(os.path.join(self.trash_dir, x)))
            if trash_files:
                last = trash_files[-1]
                shutil.move(os.path.join(self.trash_dir, last), '.')
                print(f"{self.cyan}Restored: {last}{self.reset}")
            else:
                print(f"{self.red}Trash is empty{self.reset}")
        
        elif base == 'trash-list':
            for f in os.listdir(self.trash_dir):
                print(f)
        
        elif base == 'empty-trash':
            shutil.rmtree(self.trash_dir)
            os.makedirs(self.trash_dir)
            print(f"{self.cyan}Trash emptied{self.reset}")
        
        elif base == 'ports':
            count = int(args[0]) if args else 5
            found = []
            for port in range(8000, 9000):
                if len(found) >= count:
                    break
                sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                sock.settimeout(0.5)
                result = sock.connect_ex(('localhost', port))
                if result != 0:
                    found.append(port)
                sock.close()
            for p in found:
                print(f"{self.cyan}Free port: {p}{self.reset}")
        
        elif base == 'killport':
            if args:
                port = args[0]
                try:
                    result = subprocess.run(['lsof', '-i', f':{port}'], capture_output=True, text=True)
                    if result.stdout:
                        lines = result.stdout.strip().split('\n')
                        for line in lines[1:]:
                            parts = line.split()
                            if len(parts) > 1:
                                pid = parts[1]
                                os.kill(int(pid), 9)
                                print(f"{self.cyan}Killed PID {pid} on port {port}{self.reset}")
                    else:
                        print(f"{self.red}No process on port {port}{self.reset}")
                except:
                    print(f"{self.red}Failed to kill process{self.reset}")
        
        elif base == 'alias':
            if args and '=' in args[0]:
                name, cmd = args[0].split('=', 1)
                self.aliases[name] = cmd
                self.save_aliases()
                print(f"{self.cyan}Alias saved: {name} -> {cmd}{self.reset}")
            else:
                for k, v in self.aliases.items():
                    print(f"{self.cyan}{k}{self.reset} = {v}")
        
        elif base == 'unalias':
            if args and args[0] in self.aliases:
                del self.aliases[args[0]]
                self.save_aliases()
                print(f"{self.cyan}Alias removed{self.reset}")
        
        elif base == 'path':
            if len(args) >= 2 and args[0] == 'add':
                path = args[1]
                if path not in self.path_dirs:
                    self.path_dirs.append(path)
                    os.environ['PATH'] += ':' + path
                    print(f"{self.cyan}Added to PATH: {path}{self.reset}")
            elif args and args[0] == 'list':
                for p in self.path_dirs:
                    print(p)
            else:
                print(f"{self.red}Usage: path add <dir> | path list{self.reset}")
        
        elif base == 'dupfind':
            if not args:
                print(f"{self.red}Usage: dupfind <directory>{self.reset}")
            else:
                hashes = {}
                print(f"{self.cyan}Scanning...{self.reset}")
                for root, dirs, files in os.walk(args[0]):
                    for f in files:
                        path = os.path.join(root, f)
                        try:
                            with open(path, 'rb') as file:
                                h = hashlib.md5(file.read()).hexdigest()
                            if h in hashes:
                                print(f"{self.red}Duplicate: {path}{self.reset}")
                                print(f"{self.cyan}Original: {hashes[h]}{self.reset}")
                            else:
                                hashes[h] = path
                        except:
                            pass
        
        elif base == 'run':
            if not args:
                print(f"{self.red}Usage: run <script.py> [--watch]{self.reset}")
            else:
                if args[0].endswith('.py'):
                    if '--watch' in args:
                        print(f"{self.cyan}Watching for changes...{self.reset}")
                        last_mtime = os.path.getmtime(args[0])
                        while True:
                            current_mtime = os.path.getmtime(args[0])
                            if current_mtime != last_mtime:
                                last_mtime = current_mtime
                                subprocess.run(['python', args[0]])
                            time.sleep(1)
                    else:
                        subprocess.run(['python', args[0]])
                else:
                    subprocess.run([args[0]] + args[1:])
        
        elif base == 'profile':
            if not args:
                print(f"{self.red}Usage: profile <script.py>{self.reset}")
            else:
                import cProfile
                import pstats
                import io
                prof = cProfile.Profile()
                prof.enable()
                try:
                    exec(open(args[0]).read())
                except:
                    pass
                prof.disable()
                s = io.StringIO()
                ps = pstats.Stats(prof, stream=s).sort_stats('cumulative')
                ps.print_stats(20)
                print(s.getvalue())
        
        elif base == 'deadcode':
            if not args:
                print(f"{self.red}Usage: deadcode <directory>{self.reset}")
            else:
                all_files = []
                imported = set()
                for root, dirs, files in os.walk(args[0]):
                    for f in files:
                        if f.endswith('.py'):
                            path = os.path.join(root, f)
                            all_files.append(path)
                            try:
                                with open(path, 'r') as code:
                                    for line in code:
                                        if 'import ' in line or 'from ' in line:
                                            imported.add(f)
                            except:
                                pass
                print(f"{self.cyan}Unused files:{self.reset}")
                for f in all_files:
                    if os.path.basename(f) not in imported:
                        print(f"{self.red}{f}{self.reset}")
        
        elif base == 'get':
            if not args:
                print(f"{self.red}Usage: get <url>{self.reset}")
            else:
                url = args[0]
                name = url.split('/')[-1].split('?')[0]
                print(f"{self.cyan}Downloading...{self.reset}")
                subprocess.run(['curl', '-L', '-O', url])
                if name.endswith(('.zip', '.tar.gz', '.tgz', '.tar.bz2', '.tar.xz')):
                    print(f"{self.cyan}Auto-extracting...{self.reset}")
                    subprocess.run(['unpack', name])
        
        elif base == 'reload':
            self.display_logo()
        
        elif base == 'theme':
            if args:
                color = args[0]
                if color == 'red':
                    self.cyan = "\033[91m"
                    self.red = "\033[96m"
                elif color == 'cyan':
                    self.cyan = "\033[96m"
                    self.red = "\033[91m"
                self.display_logo()
        
        elif base == 'info':
            print(f"{self.cyan}Eshell v3.0{self.reset}")
            print(f"Developer: ERROR")
            print(f"Commands: 50+")
            print(f"Aliases: {len(self.aliases)}")
            print(f"Trash: {len(os.listdir(self.trash_dir))} files")
            print(f"Backups: {len(os.listdir(self.backup_dir))}")
        
        elif base == 'history':
            try:
                with open(self.history_file, 'r') as f:
                    lines = f.readlines()
                    for i, line in enumerate(lines[-50:], 1):
                        print(f"{i:3}  {line.rstrip()}")
            except:
                pass
        
        elif base == 'env':
            for k, v in sorted(os.environ.items()):
                print(f"{self.cyan}{k}{self.reset}={v}")
        
        elif base == 'which':
            if args:
                cmd_path = shutil.which(args[0])
                if cmd_path:
                    print(cmd_path)
                else:
                    print(f"{self.red}Not found{self.reset}")
        
        elif base == 'tree':
            path = args[0] if args else '.'
            for root, dirs, files in os.walk(path):
                level = root.replace(path, '').count(os.sep)
                indent = '  ' * level
                print(f"{self.cyan}{indent}├── {os.path.basename(root)}/{self.reset}")
                subindent = '  ' * (level + 1)
                for f in files[:5]:
                    print(f"{subindent}├── {f}")
                if len(files) > 5:
                    print(f"{subindent}└── ... {len(files)-5} more")
        
        elif base == 'size':
            if args:
                try:
                    size = os.path.getsize(args[0])
                    if size < 1024:
                        print(f"{size} B")
                    elif size < 1048576:
                        print(f"{size/1024:.1f} KB")
                    else:
                        print(f"{size/1048576:.1f} MB")
                except:
                    print(f"{self.red}Cannot get size{self.reset}")
        
        else:
            try:
                subprocess.run([base] + args)
            except FileNotFoundError:
                print(f"{self.red}Command not found: {base}{self.reset}")
            except:
                pass
        
        return True
    
    def show_help(self):
        help_text = f"""
{self.cyan}{'='*60}{self.reset}
{self.cyan}ESHELL v3.0 - EXCLUSIVE COMMANDS{self.reset}
{self.cyan}{'='*60}{self.reset}

{self.red}📁 FILE MASTERS:{self.reset}
  unpack <file>         - Extract ANY archive (zip, tar, gz, bz2, xz)
  trash <file>          - Move to trash (safe delete)
  undo                  - Restore last trashed file
  trash-list            - Show trash content
  empty-trash           - Permanently clear trash
  dupfind <dir>         - Find duplicate files by content
  deadcode <dir>        - Find unused Python files
  qfind <name>          - Super fast file search

{self.red}💾 BACKUP SYSTEM:{self.reset}
  backup <dir>          - Create timestamped backup
  restore <file>        - Restore from backup

{self.red}🌐 NETWORK POWER:{self.reset}
  ports [count]         - Show free ports (8000-9000)
  killport <port>       - Kill process using specific port
  get <url>             - Download + auto-extract archives
  serve [port]          - HTTP server with QR code

{self.red}⚡ DEV TOOLS:{self.reset}
  run <script> [--watch] - Run Python with auto-restart
  profile <script>      - Performance profiler
  size <file>           - Show human-readable file size
  tree [dir]            - Directory tree view
  which <cmd>           - Show command location

{self.red}🎨 SHELL CONTROL:{self.reset}
  alias name=cmd        - Create permanent alias
  unalias <name>        - Remove alias
  path add <dir>        - Add directory to PATH
  theme [cyan/red]      - Change colors instantly
  reload                - Reload shell config
  info                  - Shell statistics
  env                   - Show environment variables
  history               - Command history

{self.red}📦 PACKAGE:{self.reset}
  pkg install/remove/list/update/search

{self.red}BASIC:{self.reset}
  ls, cd, pwd, cat, mkdir, rm, cp, mv, touch, head, tail, grep, find, clear

{self.cyan}{'='*60}{self.reset}
{self.cyan}Type 'quit' to exit | Developed by ERROR{self.reset}
"""
        print(help_text)
    
    def run(self):
        while True:
            try:
                cmd = input(self.get_prompt())
                if not self.execute(cmd):
                    break
            except KeyboardInterrupt:
                print(f"\n{self.red}Use 'quit' to exit{self.reset}")
            except EOFError:
                break
        
        print(f"{self.cyan}Bye!{self.reset}")

if __name__ == "__main__":
    try:
        import requests
        import qrcode
    except ImportError:
        os.system('pip install requests qrcode[pil]')
        os.execv(sys.executable, [sys.executable] + sys.argv)
    
    shell = Eshell()
    shell.run()
EOF
        chmod +x "$ESHELL_PATH"
        printf "${GREEN}eshell.py created successfully${RESET}\n"
        sleep 1
    fi
}

main() {
    setup_password
    print_banner
    verify_password
    check_and_create_eshell
    clear_screen
    python "$ESHELL_PATH"
}

main
