#!/bin/bash

vagrant ssh submit -c "sudo scontrol reconfigure"
vagrant ssh submit -c "sudo systemctl restart slurmctld"
vagrant ssh compute1 -c "sudo systemctl restart slurmd"
vagrant ssh compute2 -c "sudo systemctl restart slurmd"
vagrant ssh submit -c "sudo scontrol update NodeName=compute1 State=IDLE"
vagrant ssh submit -c "sudo scontrol update NodeName=compute2 State=IDLE"

vagrant ssh submit -c "sudo scontrol show nodes"

#vagrant ssh submit -c "sudo scontrol update NodeName=compute1 State=resume"
#vagrant ssh submit -c "sudo scontrol update NodeName=compute2 State=resume"
vagrant ssh submit -c "systemctl is-active --quiet slurmctld && echo slurmctld is running on submit.dundore.net"
vagrant ssh submit -c "sinfo"
vagrant ssh submit -c "sudo tail -n 10 /var/log/slurmctld.log"
vagrant ssh compute1 -c "systemctl is-active --quiet slurmd && echo slurmd is running on compute1.dundore.net"
vagrant ssh compute1 -c "sudo tail -n 10 /var/log/slurmd.log"
vagrant ssh compute2 -c "systemctl is-active --quiet slurmd && echo slurmd is running on compute2.dundore.net"
vagrant ssh compute2 -c "sudo tail -n 10 /var/log/slurmd.log"
#vagrant ssh submit -c "srun hostname"
#vagrant ssh compute1 -c "srun hostname"
#vagrant ssh compute2 -c "srun hostname"