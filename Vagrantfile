Vagrant.configure("2") do |config|
  config.vm.box = "gusztavvargadr/windows-server-2022-standard"
  config.vm.box_version = "2102.0.2404"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "4096"
  end

  # Provisionner la machine avec Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end
end
