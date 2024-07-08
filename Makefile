VAGRANT = vagrant
ANSIBLE_PLAYBOOK = ansible-playbook
INVENTORY = inventory.yml
PLAYBOOK_DIR = playbooks
SCRIPTS_DIR = scripts

.DEFAULT_GOAL := setup

help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  setup         Deploy Vagrant and run badblood playbook"
	@echo "  red           Deploy red theme playbooks"
	@echo "  blue          Deploy blue theme playbooks"
	@echo "  miscs         Deploy miscs playbooks"
	@echo "  all           Deploy all playbooks"
	@echo "  clean         Destroy Vagrant VM"
	@echo "  prune         Prune invalid entries"

setup:
	$(VAGRANT) up
	$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOK_DIR)/deploy/badblood.yml

red:
	for playbook in $(PLAYBOOK_DIR)/red/*.yml; do \
		$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $$playbook; \
	done

blue:
	for playbook in $(PLAYBOOK_DIR)/blue/*.yml; do \
		$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $$playbook; \
	done

miscs:
	for playbook in $(PLAYBOOK_DIR)/miscs/*.yml; do \
		$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $$playbook; \
	done

all: red miscs blue

clean:
	$(VAGRANT) destroy -f

prune:
	$(VAGRANT) global-status --prune

.PHONY: help setup red blue miscs all clean distclean
