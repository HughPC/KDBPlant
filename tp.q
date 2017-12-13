\p 0W
system"l C:/Users/cloug/Documents/kdb/plantGit/schema.q"
system"l ",DIR,"netLog.q"
system"l ",DIR,"users.q"

system"p 0W"
/saving the port number to a binary file
prt:system"p"
`:tp.port set prt

/log file for the data
lgF:hsym`$DIR,"dataLog/",ssr[string .z.d;".";"-"],".log"
lgFN:hsym`$DIR,"dataLog/",ssr[string .z.d;".";"-"],".names.log"

/check who is logging in
permis:{[user;pass]access::min (uTP[user]~pass; not user~""; not pass~"");access}
 
/how it is sent
UPD:set

/read what data was sent
.z.ps:{[oldzps;query]runOld:oldzps[query];
	sentTable::query 1;
 runOld}.z.ps

/.z.ps with upload to subs
.z.psStream:{[oldzps;query]runOld:oldzps[query];
	/lgFN upsert ([]tableName:enlist sentTable);
	/^send the name of the table just sent
	/lgF upsert enlist value sentTable;
	subfind["rdb*"];
	$[sentTable like "*Hist";
		sendData[insert;subs;sentTable; value sentTable];
		sendData[set;subs;sentTable; value sentTable]
	 ];
	 /!!!^changing UPD doesn't seem to work
 runOld}.z.ps


/batching process
.z.ts :{subfind["rdb*"];
	$[0 = count subs;;(sendData[UPD;subs;sentTable;value sentTable];clientHandle"show reverse fakeNYSE";show "sent new data to fakeNYSE ",string .z.p)]
 }
 
/check wherther you want batching or realtime data
optionCheck["-batch";"batching";0b];
$[batching;system"t 1000";.z.ps:.z.psStream];
