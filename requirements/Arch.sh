#! /bin/bash

echo "[+] Install dependencies packages"
sudo pacman -Syy ansible make python-pywinrm vagrant virtualbox

echo "[+] Install Vagrant plugins"
VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install vagrant-vbguest
VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install winrm
VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install winrm-elevated
VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install winrm-fs

echo "[+] Install Ansible plugins"
ansible-galaxy collection install community.windows
ansible-galaxy collection install ansible.windows
