#!/bin/bash

touch marksheet.csv
touch distribution.txt
value=$(sort mock_grading/roll_list)
cd organised/
INPUT_FILES=$(ls ../mock_grading/inputs/)
for ROLL in $value
do 
	cd $ROLL/
	mkdir student_outputs
	g++ $ROLL*.cpp -o executable 2>/dev/null
	#INPUT_FILES=$(ls ../../mock_grading/inputs/)
	for INPUT_FILE in $INPUT_FILES
	do 
		OUTPUT_FILE=$(basename $INPUT_FILE .in)
		timeout 5 ./executable < ../../mock_grading/inputs/$INPUT_FILE > student_outputs/$OUTPUT_FILE.out 2>/dev/null
	done	
	cd ..
done
cd ..

OUTPUT_FILES=$(ls mock_grading/outputs/)
for ROLL in $value
do 
	MARKS=0
	for OUTPUT_FILE in $OUTPUT_FILES
	do 
		a=$(diff organised/$ROLL/student_outputs/$OUTPUT_FILE mock_grading/outputs/$OUTPUT_FILE)
		TEST=$?
		if [ $TEST -eq 0 ]
		then 
			(( MARKS++ ))
		fi
	done
	#sed -i "$ a $ROLL,$MARKS" marksheet.csv
	echo $ROLL,$MARKS>> marksheet.csv
	echo $MARKS>> distribution.txt		
done
sort -ro distribution.txt distribution.txt







