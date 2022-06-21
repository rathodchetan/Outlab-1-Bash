#!/bin/bash

mkdir organised
value=$(cat mock_grading/roll_list)
cd organised/
for ROLL in $value
do 
    mkdir $ROLL
done

for ROLL in $value
do
	cd ../mock_grading/submissions/
	FILES=$(ls $ROLL*)
	cd ../../organised/$ROLL/
	for file_name in $FILES
	do
		ln -s ../../mock_grading/submissions/$file_name $file_name  
	done
	cd ..
done
cd ..

#echo $value
#rm -d organised
#cd organised/
