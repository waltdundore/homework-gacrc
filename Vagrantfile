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
VAGRANT_CPUS       = settings['VAGRANT_CPUS']       || 4
VAGRANT_MEMORY     = settings['VAGRANT_MEMORY']     || 4092
VAGRANT_BOX        = settings['VAGRANT_BOX']        || 'rockylinux/9'
VAGRANT_SSHFORWARD = settings['VAGRANT_SSHFORWARD'] || false
VAGRANT_RUN_CUSTOM = settings['VAGRANT_RUN_CUSTOM'] || 'never'

Vagrant.configure(2) do |config|

  config.vm.network :private_network, type: 'dhcp'
  config.ssh.forward_agent = VAGRANT_SSHFORWARD
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder ".", "/vagrant",type: "nfs",nfs_version: 4,nfs_udp: false

 #Define differences between the nodes
 # NFS: Make sure to enable nfs and forct TCP and NFSv4 on the host and set sudo rules:
    # https://developer.hashicorp.com/vagrant/docs/synced-folders/nfs#root-privilege-requirement
  config.vm.define "submit" do |submit|
    submit.vm.box = VAGRANT_BOX
    submit.vm.hostname = "submit.dundore.net"
    submit.vm.provision "shell", path: "./scratch/addswap.sh"
  end

  config.vm.define "compute1" do |compute1|
    compute1.vm.box = VAGRANT_BOX
    compute1.vm.hostname = "compute1.dundore.net"
    compute1.vm.provision "shell", path: "./scratch/addswap.sh"
  end

  config.vm.define "compute2" do |compute2|
    compute2.vm.box = VAGRANT_BOX
    compute2.vm.hostname = "compute2.dundore.net"
    compute2.vm.provision "shell", path: "./scratch/addswap.sh"
  end


  # Provision with Ansible
  config.vm.provision "ansible" do |ansible|
    ENV['ANSIBLE_ROLES_PATH'] = File.dirname(__FILE__) + "./ansible/roles"
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "./ansible/main.yml"
    ansible.raw_arguments = ["--diff"]
  end



end
