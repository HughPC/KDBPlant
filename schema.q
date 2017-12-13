/working directory
DIR:"C:/Users/cloug/Documents/kdb/plant/"
/fast load
/load:{[filename,DIR]system "l ",DIR,string filename,".q"}

/connecting to a port
conLog:{[program;login;password]
	connection:`$"::", string[get hsym `$program,".port"],":",login,":",password;hopen connection}

/update
UPD:set

/how to send data
sendData:{[UPD;clientHandles;tableName;table]
	clientHandles@\:(UPD;tableName;table);
 }

/allow programs to have arguments
args:.z.X
optionCheck:{[option;arg;default]x:`$arg;
	$[not option in args;
	(x set default; show "defult ",arg," set to ",-3!default);
	(x set (type default)$givenValue 0;givenValue:args[1 + where args like option];show "set ",arg," to given value")];
 }
 
/set viewing of data
\c 30 120

/save the pid and log file of network actions
program:.z.X[1]
programPid:hsym `$DIR,"pid/", program,".pid"
programPid set .z.i

show "loaded schema"