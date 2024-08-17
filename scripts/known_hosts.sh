#!/bin/bash
#not sure this is necessary anymore after fixing with ansible

serverlist=("submit" "compute1" "compute2" "slurmdb")

for remote_server in "${serverlist[@]}"; do
  ssh-keyscan "$remote_server" >> ~/new_keys
done

cat ~/new_keys | awk '{print $0}' | paste -sd '\n'

sort -u ~/new_keys ~/.ssh/known_hosts | uniq > ~/known_hosts_temp

mv ~/known_hosts_temp ~/.ssh/known_hosts

rm -f ~/new_keys
rm -f ~/known_hosts_temp