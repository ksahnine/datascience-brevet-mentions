#!/bin/sh

# Runs 10 EC2 instances using a Ubuntu Trusty image.
# The given parameters are respectivement the key pair name and the security group

KeyPairName=$1
SecurityGroup=$2
NbInstances=$3
TagName=inovia
AmiImage=ami-5189a661 # ubuntu-trusty-14.04-amd64-server-20150325

if [ $# -lt 3 ]
then
    echo "Usage :"
    echo "    $0 <KeyPairName> <SecurityGroup> <NbInstances>"
else
    aws ec2 run-instances --image-id $AmiImage --count $NbInstances --instance-type t2.micro --key-name $KeyPairName --security-groups $SecurityGroup
    if [ $? == 0 ]
    then
        echo "$NbInstances EC2 instances successfully created"
    fi
fi
