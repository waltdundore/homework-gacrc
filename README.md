# homework-gacrc
homework-gacrc

#Documentation
##Prerequisites:
Vagrant with vagrant-libvirt plugin
Libvirt
NFS4 server

###Stage 1: Vagrant server creation using libvirt

Virtual OS used - RockyLinux 9 (https://rockylinux.org/)
Documentation available: https://docs.rockylinux.org/


create 4 servers with a private network
submit.dundore.net 192.168.201.100 #slurm submit node slurm_controller
compute1.dundore.net 192.168.201.101 #compute_node #1
compute2.dundore.net 192.168.201.102 #compute_node #2
slurmdb.dundore.net 192.168.201.99 #slurmdb_host



###Stage 2:
Ansible Playbook provisioning
name hosts and add entries to hosts file


