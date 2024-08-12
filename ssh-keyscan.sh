#!/bin/bash

ssh-keyscan -p 22 submit.dundore.net >> /root/.ssh/known_hosts
ssh-keyscan -p 22 compute1.dundore.net >> /root/.ssh/known_hosts
ssh-keyscan -p 22 compute1.dundore.net >> /root/.ssh/known_hosts
ssh-keyscan -p 22 slurmdb.dundore.net >> /root/.ssh/known_hosts