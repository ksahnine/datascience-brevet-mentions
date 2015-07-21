#!/bin/sh

# Creates a security group whose name is the first given argument
# Adds a SSH access rule to the security group

SGName=$1
MyPublicIp=`curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`

if [ $# -lt 1 ]
then
    echo "Usage :"
    echo "    $0 <SecurityGroupName>"
else
    aws ec2 create-security-group --group-name $SGName --description "$SGName security group"
    if [ $? == 0 ]
    then
        echo "The security group $SGName is created"
        echo "Now adds a rule for SSH to the security group."
        echo "If you're behind a router, your public IP address is : $MyPublicIp"
        aws ec2 authorize-security-group-ingress --group-name $SGName --protocol tcp --port 22 --cidr ${MyPublicIp}/32
    fi
fi
