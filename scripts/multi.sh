#!/bin/bash
vagrant ssh submit -c "srun --nodes=2 --ntasks-per-node=1 hostname"