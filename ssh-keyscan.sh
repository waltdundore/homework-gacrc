#!/bin/bash

if [ "/root/.ssh/known_hosts" ]  
then 
  echo "No changes made, /root/.ssh already exists"
else 
  mkdir -p /root/.ssh/
EOF
  ssh-keyscan -p 22 submit.dundore.net >> /root/.ssh/known_hosts
  ssh-keyscan -p 22 compute1.dundore.net >> /root/.ssh/known_hosts
  ssh-keyscan -p 22 compute1.dundore.net >> /root/.ssh/known_hosts
  ssh-keyscan -p 22 slurmdb.dundore.net >> /root/.ssh/known_hosts
  chmod 0600 /root/.ssh/*
fi




