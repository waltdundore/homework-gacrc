#!/bin/bash

echo =========================
echo "Testing Vagrant Status"
echo =========================
vagrant status
echo =========================
echo "Testing Munge"
echo =========================
echo Testing munge key decode from submit to compute1
vagrant ssh submit -c "sudo munge -n | ssh -y compute1 unmunge"
echo Testing munge key decode from submit to compute2
vagrant ssh submit -c "sudo munge -n | ssh -y compute2 unmunge"

echo =========================
echo "Testing Slurm"
echo =========================
echo Testing slurmd status on compute1
vagrant ssh compute1 -c "sudo systemctl is-active --quiet slurmd && echo slurmd is running on compute1.dundore.net"
echo Testing slurmd status on compute2
vagrant ssh compute2 -c "sudo systemctl is-active --quiet slurmd && echo slurmd is running on compute2.dundore.net"
vagrant ssh submit -c "sudo scontrol update NodeName=compute1 State=IDLE"
vagrant ssh submit -c "sudo scontrol update NodeName=compute2 State=IDLE"

vagrant ssh submit -c "sudo scontrol show nodes"

echo =========================
echo "Testing Nodes"
echo =========================
echo Testing /vagrant status on compute1
vagrant ssh compute1 -c "sudo ls -la /vagrant"
echo Testing /vagrant status on compute2
vagrant ssh compute2 -c "sudo ls -la /vagrant"
