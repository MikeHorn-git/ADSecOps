VAGRANT = vagrant
ANSIBLE_PLAYBOOK = ansible-playbook
INVENTORY = inventory.yml
PLAYBOOK_DIR = playbooks
SCRIPTS_DIR = scripts

.DEFAULT_GOAL := setup

# Help target
help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  setup         Deploy Vagrant and run badblood playbook"
	@echo "  red           Deploy red theme playbook"
	@echo "  blue          Deploy blue theme playbook"
	@echo "  miscs         Deploy miscs playbook"
	@echo "  all           Deploy all playbooks"
	@echo "  clean         Destroy Vagrant VM"

setup:
	$(VAGRANT) up
	$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOK_DIR)/deploy/badblood.yml

red:
	cd $(PLAYBOOK_DIR)/red && $(ANSIBLE_PLAYBOOK) -i ../../$(INVENTORY) disable_kerberos_preauth.yml

blue:
	cd $(PLAYBOOK_DIR)/blue && $(ANSIBLE_PLAYBOOK) -i ../../$(INVENTORY) enable_kerberos_preauth.yml

miscs:
	cd $(PLAYBOOK_DIR)/miscs && $(ANSIBLE_PLAYBOOK) -i ../../$(INVENTORY) pingcastle.yml

all: red miscs blue

clean:
	$(VAGRANT) destroy -f

.PHONY: help setup red blue miscs all clean
