#!/bin/sh

# Creates a key pair whose name is the first given argument

KeyPairName=$1

if [ $# -lt 1 ]
then
    echo "Usage :"
    echo "    $0 <KeyPairName>"
else
    aws ec2 create-key-pair --key-name $KeyPairName --query 'KeyMaterial' --output text > ~/.ssh/${KeyPairName}.pem
    if [ $? == 0 ]
    then
        chmod 400 ~/.ssh/${KeyPairName}.pem
        echo "- generated private key : ~/.ssh/${KeyPairName}.pem"
    fi
fi
