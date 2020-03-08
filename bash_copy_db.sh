#!/bin/bash

# Auth: Eric Crowley
# Date: 2019-12-22
# Desc: Safely copy password db

# Current date time as string
datevar=$(date +'%Y-%m-%d_%T' | sed "s/://g")

# Make a copy of the db
cp "./eric_crowley.kdbx" "./backup_dbs/eric_crowley_local_$datevar.kdbx"

# Verify the copy was made
if [ $? -ne 0 ]; then
	echo "could not make local copy eric_crowley_local_$datevar.kdbx. Exiting"
	exit 1
else
	echo "Created eric_crowley_local_$datevar.kdbx"
fi

# Push/Pull the file
if [ -z "$1" ]; then
	echo "No argument supplied"
elif [ $1 == "push" ]; then
	scp -P 9922 ./eric_crowley.kdbx pi@crowhome.ddns.me:/home/pi/KeePassDBs/eric_crowley.kdbx
	if [ $? -ne 0 ]; then
		echo "Could not connect to pi. Failed to send local file"
	else
		echo "Copied local file to pi"
	fi
elif [ $1 == "pull" ]; then
	scp -P 9922 pi@crowhome.ddns.me:/home/pi/KeePassDBs/eric_crowley.kdbx ./eric_crowley.kdbx
	if [ $? -ne 0 ]; then
		echo "Could not connect to pi. Failed to get remote file"
	else
		echo "Copied file on pi to local"
	fi
else
	echo "$1 does not equal 'push' or 'pull'. Enter valid command"
fi
