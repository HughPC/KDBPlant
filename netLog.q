/removed all the prints and does not wirte to a log file anymore to save write!!!
/get them from netLog.3Print <-----


/------setting up network logging---------
networkLog:([]opentime:`timestamp$();closetime:`timestamp$();user:`$();live:`boolean$();allowed:`boolean$();handle:"i"$();query:();typemsg:());

/get handle of subs
subfind:{[sub]subs:: exec distinct handle from networkLog where user like sub,live=1b}


/check username and password before opening connection
.z.pwOld:.z.pw:{[user;pass]$[permis[user;pass];
	0N!(.z.P;"Connection accepted(", string[.z.w],") from:",string[user]," using password:", pass);
	0N!(.z.P;"Connection refused(", string[.z.w],") from:",string[user]," using password:", pass)];
 access}
/.z.pw with data collection
.z.pwSchema:.z.pw:{[oldzpw;user;pass]runOld:oldzpw[user;pass];
	`networkLog insert datalist:(.z.P;0Np;user;1b;runOld;.z.w;"--";"pw");
 runOld}.z.pw

/.z.ps
.z.psOld:.z.ps:{[query]value query}
/insert data .z.ps
.z.psSchema:.z.ps :{[oldzps;query]runOld:oldzps[query];
	;	
 runOld}.z.ps

/.z.pg
.z.pgOld:.z.pg:{[query]value query}
/with insert
.z.pgSchema:.z.pg :{[oldzpg;query]runOld:oldzpg[query];
 runOld}.z.pg
/with upload
/.z.pg :{[oldzpg;query]runOld:oldzpg[query];runOld}.z.pg

/.z.pc
.z.pcOld:.z.pc:{[oldhandle]0N!(`.z.pc;.z.P;"Connection closed for handle:",string oldhandle);-1""}
/with insert
.z.pcSchema:.z.pc :{[oldzpc;oldhandle]runOld:oldzpc[oldhandle];
	update live:not live,closetime:.z.P from `networkLog where handle=oldhandle,i=last i;
 runOld}.z.pc

