#!/bin/bash

if [ $# -eq 2 ]
then 
    wget -np -nH -r --reject html,tmp $1 --cut-dirs=$2
    FILE=$(ls -d */)
    mv $FILE mock_grading/
else 
    echo 'Usage: bash download.sh <link to directory> <cut-dirs argument>'

fi