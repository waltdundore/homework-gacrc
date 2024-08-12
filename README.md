# homework-gacrc

# Documentation
## Prerequisites:
This was tested on Fedora 40 as a host using the following:
- Vagrant with vagrant-libvirt plugin
- Libvirt
- NFS4 server
- make

### Stage 1: Vagrant server creation using libvirt

#### Makefile
The following options are handled by the Makefile:
```
install:
	vagrant up --no-destroy-on-error

debug:
	vagrant up --debug --no-destroy-on-error

clean:
	vagrant destroy -f && rm -rf .vagrant
    
```


To start the build process, navigate to the root directory and execute:
```
make install
```

Virtual OS used - Ubuntu 22.04


#### create 4 servers with a private network
```
submit.dundore.net 192.168.201.100 #slurm submit node slurm_controller
compute1.dundore.net 192.168.201.101 #compute_node #1
compute2.dundore.net 192.168.201.102 #compute_node #2
slurmdb.dundore.net 192.168.201.99 #slurmdb_host
```


### Stage 2:
#### Ansible Playbook provisioning

##### Roles
- common
  - Install and configure chrony
  - Update the /etc/hosts file
  - copy sudoers file into /etc/sudoers.d/10_vagrant and validate for vagrant user
  - install and enable sshd
  - ssh-keyscan to known_hosts
- slurm_controller
 - Install munge packages, apply permissions and start munge
 - verify munge key
   -Security note: change the munge key
- compute_node
 - Install munge packages, apply permissions and start munge
 - copy and verify munge key

- slurmdb

name hosts and add entries to hosts file


