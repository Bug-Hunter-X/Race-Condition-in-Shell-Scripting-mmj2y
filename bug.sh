#!/bin/bash

# This script demonstrates a race condition in shell scripting.

# Create two files
touch file1.txt
touch file2.txt

# Start two background processes that will write to the same file concurrently.
# Process 1 writes '1' to file1.txt
(echo "1" > file1.txt) &
PID1=$!

# Process 2 writes '2' to file1.txt
(echo "2" > file1.txt) &
PID2=$!

# Wait for both processes to complete
wait $PID1 $PID2

# Check the content of file1.txt
cat file1.txt

# Expected output is either '1' or '2', but due to race condition,
# either one of the number will be overwritten by the other