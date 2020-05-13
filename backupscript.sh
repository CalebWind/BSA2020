#!/bin/bash

echo "Please enter a directory to compress: " $directory

if [[ ! -d $directory ]] 
	echo "Not a directory"
	exit 1

echo ">>>Starting Backup<<<"

# Create a backup of the home directory

now=$(date)
tar -czf /tmp/mybackup-$now.tar.gz -C $directory . 2> /dev/null

# Add error echecking to make sure the tar command was successful

if [[ $? == 0 ]]
then
	echo ">>>Backup successful<<<"
else
	echo ">>>Backup failed<<<"
exit 1
fi

echo "Please enter the username of the remote location: "
read $username
echo "Please enter the IP of the remote location: "
read $ip
echo "Please enter the port of the remote location: "
read $port
echo "Where would you like to save the backup: "
read $buplocation

while [[ ! -d $buplocation  ]]
	echo "Not a directory, please enter a directory"
	read $buplocation


scp -P $port /tmp/mybackup-$now.tar.gz $username@$ip:$buplocation
if [[ $? == 0]]
then
	echo ">>Remote Backup Successful<<"
else
	echo ""
	exit 1
fi

echo ">>>Backup Complete<<<"
