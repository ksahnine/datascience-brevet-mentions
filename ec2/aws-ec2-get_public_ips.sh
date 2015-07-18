#!/bin/sh

# Returns public IP addresses of the EC2 instances
# This script checks if jq is installed on the current system

# Checks if jq is installed
if [ -z "`type jq 2>/dev/null`" ]
then
    echo "jq is not installed on the current system."
    echo "Please refer to [http://stedolan.github.io/jq/download/]"
    exit 1
else
    aws ec2 describe-instances | jq '.Reservations[].Instances[].NetworkInterfaces[].Association.PublicIp' | sed 's/"//g' | grep -v null
fi
