#!/usr/bin/env python3
import os
import sys
import importlib.util
import subprocess
from pathlib import Path

class PluginManager:
    def __init__(self):
        self.plugin_dir = os.path.expanduser("~/.eshell/plugins")
        self.enabled_plugins_file = os.path.expanduser("~/.eshell/enabled_plugins")
        
        if not os.path.exists(self.plugin_dir):
            os.makedirs(self.plugin_dir)
    
    def install_plugin(self, plugin_name, plugin_url=None):
        plugin_path = os.path.join(self.plugin_dir, f"{plugin_name}.py")
        
        if plugin_url:
            import requests
            response = requests.get(plugin_url)
            with open(plugin_path, 'w') as f:
                f.write(response.text)
        else:
            print(f"Creating empty plugin template: {plugin_name}")
            template = f'''
def setup():
    return {{
        'name': '{plugin_name}',
        'version': '1.0',
        'author': 'User',
        'commands': {{
            '{plugin_name}_hello': 'print("Hello from {plugin_name}")',
            '{plugin_name}_help': 'print("Available commands for {plugin_name}")'
        }}
    }}
'''
            with open(plugin_path, 'w') as f:
                f.write(template)
        
        print(f"✓ Plugin {plugin_name} installed")
        self.enable_plugin(plugin_name)
    
    def uninstall_plugin(self, plugin_name):
        plugin_path = os.path.join(self.plugin_dir, f"{plugin_name}.py")
        if os.path.exists(plugin_path):
            os.remove(plugin_path)
            self.disable_plugin(plugin_name)
            print(f"✓ Plugin {plugin_name} uninstalled")
    
    def enable_plugin(self, plugin_name):
        enabled = self.get_enabled_plugins()
        if plugin_name not in enabled:
            enabled.append(plugin_name)
            with open(self.enabled_plugins_file, 'w') as f:
                f.write('\n'.join(enabled))
            print(f"✓ Plugin {plugin_name} enabled")
    
    def disable_plugin(self, plugin_name):
        enabled = self.get_enabled_plugins()
        if plugin_name in enabled:
            enabled.remove(plugin_name)
            with open(self.enabled_plugins_file, 'w') as f:
                f.write('\n'.join(enabled))
            print(f"✓ Plugin {plugin_name} disabled")
    
    def get_enabled_plugins(self):
        if os.path.exists(self.enabled_plugins_file):
            with open(self.enabled_plugins_file, 'r') as f:
                return [p.strip() for p in f.readlines() if p.strip()]
        return []
    
    def list_plugins(self):
        print("\n📦 Installed Plugins:")
        print("-" * 40)
        for f in os.listdir(self.plugin_dir):
            if f.endswith('.py'):
                plugin_name = f[:-3]
                enabled = "✅" if plugin_name in self.get_enabled_plugins() else "❌"
                print(f"  {enabled} {plugin_name}")
    
    def load_plugins(self):
        commands = {}
        enabled_plugins = self.get_enabled_plugins()
        
        for plugin_name in enabled_plugins:
            plugin_path = os.path.join(self.plugin_dir, f"{plugin_name}.py")
            if os.path.exists(plugin_path):
                spec = importlib.util.spec_from_file_location(plugin_name, plugin_path)
                module = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(module)
                
                if hasattr(module, 'setup'):
                    plugin_info = module.setup()
                    if 'commands' in plugin_info:
                        commands.update(plugin_info['commands'])
                        print(f"✓ Loaded plugin: {plugin_name}")
        
        return commands

if __name__ == "__main__":
    pm = PluginManager()
    
    if len(sys.argv) < 2:
        print("Usage: plugins.py [install|uninstall|enable|disable|list] <plugin_name> [url]")
        sys.exit(1)
    
    cmd = sys.argv[1]
    
    if cmd == "install" and len(sys.argv) >= 3:
        url = sys.argv[3] if len(sys.argv) > 3 else None
        pm.install_plugin(sys.argv[2], url)
    elif cmd == "uninstall" and len(sys.argv) >= 3:
        pm.uninstall_plugin(sys.argv[2])
    elif cmd == "enable" and len(sys.argv) >= 3:
        pm.enable_plugin(sys.argv[2])
    elif cmd == "disable" and len(sys.argv) >= 3:
        pm.disable_plugin(sys.argv[2])
    elif cmd == "list":
        pm.list_plugins()
