#!/bin/bash

echo =========================
echo "Testing Vagrant Status"
echo =========================
vagrant status
echo =========================
echo "Testing Munge"
echo =========================
echo Testing permissions on submit munge key.
vagrant ssh submit -c "sudo ls -la /etc/munge/munge.key"
vagrant ssh submit -c "sudo systemctl restart munge"
echo Testing permissions on compute1 munge key.
vagrant ssh compute1 -c "sudo ls -la /etc/munge/munge.key"
vagrant ssh compute1 -c "sudo systemctl restart munge"
echo Testing permissions on compute2 munge key.
vagrant ssh compute2 -c "sudo ls -la /etc/munge/munge.key"
vagrant ssh compute2 -c "sudo systemctl restart munge"
echo Testing munge key decode from submit to compute1
vagrant ssh submit -c "sudo munge -n | ssh compute1 unmunge"
echo Testing munge key decode from submit to compute2
vagrant ssh submit -c "sudo munge -n | ssh compute2 unmunge"

echo =========================
echo "Testing Slurm"
echo =========================
echo "Restart services"
vagrant ssh submit -c "sudo scontrol reconfigure"
vagrant ssh submit -c "sudo systemctl restart slurmctld"
vagrant ssh submit -c "sudo systemctl is-active --quiet slurmctld && echo slurmctld is running on submit.dundore.net"
vagrant ssh compute1 -c "sudo systemctl restart slurmd"
vagrant ssh compute2 -c "sudo systemctl restart slurmd"
echo Testing slurmd status on compute1
vagrant ssh compute1 -c "sudo systemctl status slurmd"
echo Testing slurmd status on compute2
vagrant ssh compute2 -c "sudo systemctl status slurmd"
vagrant ssh submit -c "sudo scontrol update NodeName=compute1 State=IDLE"
vagrant ssh submit -c "sudo scontrol update NodeName=compute2 State=IDLE"

vagrant ssh submit -c "sudo scontrol show nodes"