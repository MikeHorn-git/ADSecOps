#! /bin/bash

echo "[+] Install dependencies packages"
sudo apt update; sudo apt install virtualbox ansible vagrant python3-winrm -y

echo "[+] Install Vagrant plugins"
vagrant plugin install vagrant-vbguest
vagrant plugin install winrm
vagrant plugin install winrm-elevated
vagrant plugin install winrm-fs

echo "[+] Install Ansible plugins"
ansible-galaxy collection install community.windows
ansible-galaxy collection install ansible.windows
