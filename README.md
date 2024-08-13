# homework-gacrc

# Documentation

### Security note:
- /secure directory - The munge key and private ssh key are encrypted using ansible vault. For this to work properly, there must be a file named '.vault_password.txt' containing the password to decrypt them using ansible vault.  For this demo the vault password is set to 
```
P@ssw0rd
```

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
  - I recommend generating a new ssh key and save the public and private key in the secure/.ssh directory. They are linked to insecure_key and insecure_key.pub "ssh-keygen -b 4096"
- slurm_controller
 - Install munge packages, apply permissions and start munge
 - verify munge key
   -Security note: change the munge key - put your key in the secure/munge directory and name it munge.key.j2. 
- compute_node
 - Install munge packages, apply permissions and start munge
 - copy and verify munge key

- slurmdb

name hosts and add entries to hosts file


