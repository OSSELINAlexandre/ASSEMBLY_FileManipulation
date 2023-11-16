#! /bin/bash

LD_LIBRARY_PATH=.
export LD_LIBRARY_PATH

object_file_name_write='object_write.o'
executable_name_write='write'
assembly_name_write='write.s'

object_file_name_read='object_read.o'
executable_name_read='read'
assembly_name_read='read.s'

object_file_name_write_buffer='object_bufferwrite.o'
assembly_name_write_buffer='bufferwrite.s'

object_file_name_read_buffer='object_bufferread.o'
assembly_name_read_buffer='bufferread.s'
lib_name='libreadwrite.so'
echo
echo '[ASSEMBLY_FileManipulation : WritingReadingRecords]'
echo 
echo 'Creating a shared library with both reading and writing from/to buffer.'
echo 
echo '==================================='
as -g -o ${object_file_name_write_buffer} ${assembly_name_write_buffer}
as -g -o ${object_file_name_read_buffer} ${assembly_name_read_buffer}
ld -shared ${object_file_name_read_buffer} ${object_file_name_write_buffer} -o ${lib_name}
echo
echo 'Shared library : OK'
as -g -o ${object_file_name_write} ${assembly_name_write}
ld -L . -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o ${executable_name_write} -lreadwrite ${object_file_name_write}
echo
echo 'Writing Executable created : OK'
echo
as -g -o ${object_file_name_read} ${assembly_name_read}
ld -L . -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o ${executable_name_read} -lreadwrite ${object_file_name_read}
echo 'Reading Executable created : OK'
echo 
echo '==============RESULTS=============='
./${executable_name_write}
echo 
echo "-->Records should be diplayed here : "
echo 
./${executable_name_read}
echo 
echo "-->And it should be exactly the same as follow : "
echo 
cat data.dat
echo


