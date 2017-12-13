/gets all the file names as arguments
file:.z.x


endTask:{[file]killCmd:"kill -9 ",string get hsym`$file;
	show "killing ",file;
 system killCmd}

/will error if no file names are given
$[(count file)~0;show "need to give PID file name";endTask'[file]]

\\