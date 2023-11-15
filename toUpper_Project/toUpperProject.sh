#! /bin/bash

object_file_name='object_upper.o'
executable_name='to_upper'
input_file_name='input.txt'
output_file_name='output.txt'
echo '[ASSEMBLY_FileManipulation : toUpper]'
echo 
echo 'Compiling the assembly convertUpper.s file.'
echo 
echo '=============='
as -g -o ${object_file_name} convertUpper.s

echo 'Compiled : OK'

ld -o ${executable_name} ${object_file_name}

echo 'Linked   : OK'

if [ ! -f ${output_file_name} ]; then

	echo 'output.txt not existing, creating it.'
	touch ${output_file_name}
fi


./${executable_name} ${input_file_name} ${output_file_name}

echo 'Executed : OK'
echo '=============='
echo 
echo '=========RESULTS========='
echo 
echo "-->This text should be in lowercase : "
echo 
cat ${input_file_name}
echo 
echo "-->The previous text should be in uppercase : "
echo 
cat ${output_file_name}
