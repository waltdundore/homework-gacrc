# Project Status Report

**Project Name: homework-gacrc**  

---

## 1. Summary

- **Overall Status:** On track
- **Summary of Progress:** running a batch job is not shared among the hosts - troubleshooting

## 2. Milestones and Deliverables

- **Completed Milestones:** 
  - *Vagrantfile*
  - *Ansible infrastructure*
  - *slurmctld node operational*
  - *slurmd nodes operational*
  - *nodes operational and reporting
  - *manual testing*

- **Upcoming Milestones:** 
  - *slurmdb integration*
  - *automated testing*
  

## 4. Issues and Risks

- **Current Issues:**
  - *Issue 1* - Node Error: UNKNOWN+DRAIN+INVALID_REG (well if you don't add munge to the slurm.conf this happens....)


---

**Prepared by: Walter Dundore**  
**Date: 20240816 14:46**



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

Notable packages installed:
```
libnfs-5.0.3-1
libvirt-10.1.0-3
libvirt-devel
libvirt-libs
make-4.4.1-6
nfs-utils-2.6.4-0
vagrant-2.4.1-1


```

#### NFS Config
```
[nfsd]
udp=n
tcp=y
vers3=n
vers4=y
```
### Vagrant 
/etc/sudoers.d/10_vagrant file added to ease vagrant NFS shares
```
Cmnd_Alias VAGRANT_EXPORTS_CHOWN = /bin/chown 0\:0 /tmp/vagrant-exports
Cmnd_Alias VAGRANT_EXPORTS_MV = /bin/mv -f /tmp/vagrant-exports /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /usr/bin/systemctl status --no-pager nfs-server.service
Cmnd_Alias VAGRANT_NFSD_START = /usr/bin/systemctl start nfs-server.service
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
%vagrant ALL=(root) NOPASSWD: VAGRANT_EXPORTS_CHOWN, VAGRANT_EXPORTS_MV, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY

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

Virtual OS used - Started with Debian 11 which had trouble with cgroups. Switched to Alma Linux 9.


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
  
- slurm_controller
 - Install slurmctld and apply /etc/slurm.conf

- compute_node
 - Install slurmd and apply /etc/slurm.conf

- slurmdb
 - pending

# Testing
## Test the installation
```
$ scripts/test.sh

Current machine states:

submit                    running (libvirt)
compute1                  running (libvirt)
compute2                  running (libvirt)
```
The above should test munge and slurm and verify that all is working correctly. 

```
$ vagrant ssh submit -c "sudo scontrol show nodes"

```