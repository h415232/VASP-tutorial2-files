#!/bin/bash

# NAME: qsub_wait.sh
#
# Description
#
# This script will check if submission of the job to 
#   the queue is possible (since there is an upper limit
#   of 60 jobs queued per user).
# This also returns the ID of the job submitted
#
# 2018.09.05 - v1 - Creation
#

submitfile=$1
jobname=$2

submit="F"

# Will loop until the job is submitted
while [ "$submit" == "F" ] 
do
  # Submit the job and put the output to var 'res'
  res=$(qsub $submitfile -N $jobname)

  # If the qsub will NOT return a job id, then
  #   return F, otherwise, return Job ID
  if [[ "${res:0:1}" =~ ^[[:digit:]] ]]; then  
    submit="$(echo $res | cut -d'.' -f1)"
  else
    submit="F"
  fi

done

# Output the Job ID
echo $submit

