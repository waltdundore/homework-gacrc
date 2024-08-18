# Project Status Report
---

## 1. Summary

- **Overall Status:** Main objectives complete

## 2. Milestones and Deliverables

- **Completed Milestones:** 
  - *Vagrantfile*
  - *Ansible infrastructure*
  - *slurmctld node operational*
  - *slurmd nodes operational*
  - *nodes operational and reporting*
  - *manual testing*
  - *nfs server on submit node*
  - */mnt/nfs/scripts scripts mount on compute nodes*

- **Upcoming Milestones:** 
  
  - *nfs homedir mount on compute nodes*
  - *slurmdb integration*
  - *automated testing*
---

**Prepared by: Walter Dundore**  
**Date: 20240818 14:30**

# Quick start
```
cd <directory to house project>
git clone https://github.com/waltdundore/homework-gacrc.git
cd homework-gacrc
make install
scripts/test.sh #Test that the install has  gone correctly and finish configs
scripts/multi.sh #Run a command across both nodes 
```

# Documentation

### Security note:
- This demo/proof of concept has insecure keys in place so it can work as a demo. 
- /secure directory - Public and private keys and munge key will need to be updated for security. These are stored in: 
```
./homework-gacrc/ansible/roles/common/templates
```
The private key and munge key are protected using ansible vault.  For this to work properly, there must be a file named '.vault_password.txt' containing the password to decrypt them located in the ./secure directory.  For this demo the password file has been provided and the vault password is set to 

```
P@ssw0rd
```

#### Change this password by decrypting and re-encrypting these files. Set the new password in the .vault_password file in the ./secure directory

## Prerequisites:

This was tested on Fedora 40 (yes, even the host computer is open source only) as a host using the following:
- [Vagrant](https://developer.hashicorp.com/vagrant/install) with [vagrant-libvirt plugin](https://github.com/vagrant-libvirt/vagrant-libvirt)
- Libvirt
- NFS4 server
- make

#### Notable packages installed:
```
libnfs-5.0.3-1
libvirt-10.1.0-3
libvirt-devel
libvirt-libs
make-4.4.1-6
nfs-utils-2.6.4-0
vagrant-2.4.1-1
```
[Using synced nfs folders with vagrant](https://developer.hashicorp.com/vagrant/docs/synced-folders/nfs)

#### Using NFS 4 and TCP
```
[nfsd]
udp=n
tcp=y
vers3=n
vers4=y
```


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

Virtual OS used - Alma Linux 9.


#### create 4 servers with a private network
```
submit.dundore.net 192.168.201.100 #slurm submit node slurm_controller
compute1.dundore.net 192.168.201.101 #compute_node #1
compute2.dundore.net 192.168.201.102 #compute_node #2
slurmdb.dundore.net 192.168.201.99 #slurmdb_host
```

![diagram of network](https://github.com/waltdundore/homework-gacrc/blob/production/img/diagram.png?raw=true)


### Stage 2:
#### Ansible Playbook provisioning

##### Roles
- common
  - Install and configure chrony for time synchronization
  - Update the /etc/hosts file for name resolution
  - copy sudoers file into /etc/sudoers.d/10_vagrant and validate for vagrant user permissions
  - install and enable sshd
  - ssh-keyscan to known_hosts
  - install munge packages, munge key and start munge
  
- slurm_controller, compute_node, slurmdb:
 custom package installs

# Testing
## Test the installation

Run the test script to verify all went well and finalize configuration:
```
$ scripts/test.sh
```

Test the setup with scripts/multi.sh
```
$ scripts/multi.sh
compute1.dundore.net
compute2.dundore.net

```
