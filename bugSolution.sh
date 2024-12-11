#!/bin/bash

# This script demonstrates a solution to the race condition using a lock file.

# Create two files
touch file1.txt
touch file2.txt

# Create a lock file
lockfile="file1.txt.lock"

# Process 1
(flock -n $lockfile || exit 1; echo "1" > file1.txt; flock -u $lockfile) &
PID1=$!

# Process 2
(flock -n $lockfile || exit 1; echo "2" > file1.txt; flock -u $lockfile) &
PID2=$!

# Wait for both processes to complete
wait $PID1 $PID2

# Check the content of file1.txt
cat file1.txt

# Expected output is either '1' or '2' (depending on which process acquired the lock first), but not a mix of both.