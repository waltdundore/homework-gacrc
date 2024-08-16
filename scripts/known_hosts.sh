#!/bin/bash
#not sure this is necessary anymore after fixing with ansible

serverlist=("submit" "compute1" "compute2")

for remote_server in "${serverlist[@]}"; do
  ssh-keyscan "$remote_server" >> /tmp/new_keys
done

cat /tmp/new_keys | awk '{print $0}' | paste -sd '\n'

sort -u /tmp/new_keys ~/.ssh/known_hosts | uniq > /tmp/known_hosts_temp

mv /tmp/known_hosts_temp ~/.ssh/known_hosts

rm -f /tmp/new_keys
rm -f /tmp/known_hosts_temp