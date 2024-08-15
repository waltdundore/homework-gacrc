#!/bin/bash

scontrol reconfig
scontrol update NodeName=compute1 State=resume
scontrol update NodeName=compute2 State=resume