# -*- mode: ruby -*-
# vi: set ft=ruby :

# Load settings
require 'yaml'
settings_path = '.vagrant.yml'
settings = {}

if File.exist?(settings_path)
  settings = YAML.load_file(settings_path)
end

# Overrides and defaults
VAGRANT_CPUS       = settings['VAGRANT_CPUS']       || 2
VAGRANT_MEMORY     = settings['VAGRANT_MEMORY']     || 4096
VAGRANT_BOX        = settings['VAGRANT_BOX']        || 'almalinux/9'
VAGRANT_SSHFORWARD = settings['VAGRANT_SSHFORWARD'] || false

Vagrant.configure(2) do |config|

  config.vm.provider "libvirt" do |libvirt|
    libvirt.cpu_mode = 'host-model' # Ensures CPU features are passed through
    libvirt.cpus = VAGRANT_CPUS
    libvirt.memory = VAGRANT_MEMORY
  end  

 #Define differences between the nodes
 # NFS: Make sure to enable nfs and forct TCP and NFSv4 on the host and set sudo rules:
    # https://developer.hashicorp.com/vagrant/docs/synced-folders/nfs#root-privilege-requirement

  # Submit node
  config.vm.define "submit" do |submit|
    submit.vm.box = VAGRANT_BOX
    submit.vm.hostname = "submit.dundore.net"
    submit.vm.network "private_network", ip: "192.168.201.100"
  end

  # Compute node #1
  config.vm.define "compute1" do |compute1|
    compute1.vm.box = VAGRANT_BOX
    compute1.vm.hostname = "compute1.dundore.net"
    compute1.vm.network "private_network", ip: "192.168.201.101"
  end

  # Compute node #2
  config.vm.define "compute2" do |compute2|
    compute2.vm.box = VAGRANT_BOX
    compute2.vm.hostname = "compute2.dundore.net"
    compute2.vm.network "private_network", ip: "192.168.201.102"
  end

  #Disable the slurmdb node 
 # config.vm.define "slurmdb" do |slurmdb|
 #   slurmdb.vm.box = VAGRANT_BOX
 #   slurmdb.vm.hostname = "slurmdb.dundore.net"
 #   slurmdb.vm.network "private_network", ip: "192.168.201.99"
 # end

 config.vm.provision "shell", path: "scripts/addswap.sh"

 config.ssh.forward_agent = VAGRANT_SSHFORWARD
 config.vm.synced_folder '.', '/vagrant', disabled: true
 config.vm.synced_folder ".", "/vagrant",type: "nfs",nfs_version: 4,nfs_udp: false

# Provision with Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.vault_password_file = "./secure/.vault_pass.txt"
    ENV['ANSIBLE_ROLES_PATH'] = File.dirname(__FILE__) + "./ansible/roles"
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "./ansible/main.yml"
    ansible.inventory_path = "ansible/inventory.ini"
    ansible.raw_arguments = ["--diff"]
    ansible.verbose = "vvv"
  end

  # nfs directory disappears on compute nodes after ansible provisioning -troubleshooting
  config.vm.synced_folder ".", "/vagrant",type: "nfs",nfs_version: 4,nfs_udp: false

end
