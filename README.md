# Description
School Project

# Requirements
* Linux Host (Tested on Arch)
* Virtualbox
* Ansible
* Vagrant

# Installation
```bash
git clone https://github.com/MikeHorn-git/ADSecOps.git
chmod +x ./requirements/Arch.sh
./requirements/Arch.sh
make setup
```

# Usage
```bash
Usage: make <target>
Targets:
  setup         Deploy Vagrant and run badblood playbook
  deploy        Install requirements
  red           Deploy red theme playbooks
  blue          Deploy blue theme playbooks
  scans         Deploy scans playbooks
  all           Deploy all playbooks
  report        Create report in pdf format
  clean         Destroy Vagrant VM
  prune         Prune invalid entries
  distclean     Execute clean and prune command
```

# Known Issues
```bash
An error occurred executing a remote WinRM command.

Shell: Cmd
Command: hostname
Message: Digest initialization failed: initialization error
```
Enable legacy cipher to openssl :
```bash
export OPENSSL_CONF=./.openssl-legacy.cnf
```
