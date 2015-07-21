#!/bin/sh

# Configure "automagically" the ~./ssh/config file
# The given parameter is the EC2 key pair name

KeyPairName=$1
PrivateKey=~/.ssh/${KeyPairName}.pem
SshConfig=~/.ssh/config

if [ $# -lt 1 ]
then
    echo "Usage :"
    echo "    $0 <KeyPairName>"
    exit 1
fi

# Checks if the private key exists
if [ ! -f $PrivateKey ]
then
    echo "The private key $PrivateKey does not exist"
    exit 2
fi

# Checks if jq is installed
if [ -z "`type jq 2>/dev/null`" ]
then
   echo "jq is not installed on the current system."
   echo "Please refer to [http://stedolan.github.io/jq/download/]"
   exit 3
fi

PublicEC2Ips=`aws ec2 describe-instances | jq '.Reservations[].Instances[].NetworkInterfaces[].Association.PublicIp' | sed 's/"//g' | grep -v null`
for Ip in $PublicEC2Ips
do
    echo "Adding $Ip to $SshConfig file"
    cat >> $SshConfig <<EOF
Host $Ip
    IdentityFile $PrivateKey
    User ubuntu
    StrictHostKeyChecking no
EOF
done
