VAGRANT = vagrant
LATEX = pdflatex
ANSIBLE_PLAYBOOK = ansible-playbook
INVENTORY = inventory.yml
PLAYBOOK_DIR = playbooks
SCRIPTS_DIR = scripts

.DEFAULT_GOAL := help

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

setup:
	$(VAGRANT) up
	$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOK_DIR)/setup/badblood.yml

deploy:
	for playbook in $(PLAYBOOK_DIR)/deploy/*.yml; do \
		$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $$playbook; \
	done

red:
	for playbook in $(PLAYBOOK_DIR)/red/*.yml; do \
		$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $$playbook; \
	done

blue:
	for playbook in $(PLAYBOOK_DIR)/blue/*.yml; do \
		$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $$playbook; \
	done

scans:
	for playbook in $(PLAYBOOK_DIR)/scans/*.yml; do \
		$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $$playbook; \
	done

all: red miscs blue

clean:
	$(VAGRANT) destroy -f

prune:
	$(VAGRANT) global-status --prune

distclean: clean prune

.PHONY: help setup deploy red blue scans all report clean prune distclean
