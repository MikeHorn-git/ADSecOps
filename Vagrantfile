# frozen_string_literal: true

Vagrant.configure('2') do |config|
  config.vm.box = 'gusztavvargadr/windows-server-2022-standard'
  config.vm.box_version = '2102.0.2404'
  config.vm.network 'private_network', type: 'dhcp'

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = 2
    vb.memory = '4096'
    vb.name = 'ADSecOps'
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'playbooks/setup/setup.yml'
    ansible.compatibility_mode = '2.0'
    ansible.inventory_path = 'inventory.yml'
  end
end
