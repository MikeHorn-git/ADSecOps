# Dirs
DIR_ANSIBLE   := ansible-playbook
DIR_INVENTORY := inventory.yml
DIR_PLAYBOOK  := playbooks

# Files
FILE_ANSIBLE  := ./.ansible-lint

.DEFAULT_GOAL := help
.ONESHELL:

help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  help          Display this help message"
	@echo "  setup         Deploy Vagrant and run badblood playbook"
	@echo "  deploy        Install requirements"
	@echo "  red           Deploy red theme playbooks"
	@echo "  blue          Deploy blue theme playbooks"
	@echo "  scans         Deploy scans playbooks"
	@echo "  all           Deploy all playbooks"
	@echo "  clean         Destroy Vagrant VM"
	@echo "  prune         Prune invalid entries"
	@echo "  distclean     Execute clean and prune command"
	@echo "  lint          Lint Ansible, README and Vagrantfile"

setup:
	vagrant up
	$(DIR_ANSIBLE) -i $(DIR_INVENTORY) $(DIR_PLAYBOOK)/setup/badblood.yml

deploy:
	for playbook in $(DIR_PLAYBOOK)/deploy/*.yml; do \
		$(DIR_ANSIBLE) -i $(DIR_INVENTORY) $$playbook; \
	done

red:
	for playbook in $(DIR_PLAYBOOK)/red/*.yml; do \
		$(DIR_ANSIBLE) -i $(DIR_INVENTORY) $$playbook; \
	done

blue:
	for playbook in $(DIR_PLAYBOOK)/blue/*.yml; do \
		$(DIR_ANSIBLE) -i $(DIR_INVENTORY) $$playbook; \
	done

scans:
	for playbook in $(DIR_PLAYBOOK)/scans/*.yml; do \
		$(DIR_ANSIBLE) -i $(DIR_INVENTORY) $$playbook; \
	done

all: red miscs blue

clean:
	vagrant destroy -f

prune:
	vagrant global-status --prune

distclean: clean prune

lint:
	@ansible-lint -c $(FILE_ANSIBLE) $(DIR_ANSIBLE)
	@mdl README.md
	@rubocop -A .

.PHONY: help setup deploy red blue scans all report clean prune distclean lint
