#!/bin/bash

#Creates a file called metadata.txt in the current directory
touch metadata.txt

#Retrieves and store meta-data
curl -w "\n" http://169.254.169.254/latest/meta-data/hostname > metadata.txt
curl -w "\n" http://169.254.169.254/latest/meta-data/iam/info/ >> metadata.txt
curl -w "\n" http://169.254.169.254/latest/meta-data/security-groups >> metadata.txt
