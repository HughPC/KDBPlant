\p 0W
\l c:/Users/cloug/Documents/kdb/plantGit/schema.q
system"l ",DIR,"tables.q"
system"l ",DIR,"netLog.q"
system"l ",DIR,"users.q"
/load["netLog"]

/saving the port number to a binary file
prt:system"p"
`:rdb.port set prt

/connecting to tp
tpH:conLog["tp";program;"pass"]

/check who is logging in
permis:{[user;pass]access::min (uRDB[user]~pass; not user~""; not pass~"");access}

/reset .z.pg
.z.pg:.z.pgOld

/allow counting the number of bids or asks
getTick:{[tableName]stocks::exec distinct ticker from tableName}
cbid:{[stock;tableName]count select from tableName where not biddate=0Np,ticker=stock}
cask:{[stock;tableName]count select from tableName where not askdate=0Np,ticker=stock}
getTableLen:{[tableName]getTick[tableName];
	stockCount::([]sym:stocks;askcount:cask'[stocks;tableName];bidcount:cbid'[stocks;tableName];lowbid:value exec last bid by ticker from BA where not bid=0Nf;lowask:value exec last ask by ticker from BA where not ask=0Wf)
 }
 
/symBid:exec from sym where bidcount < 10
/symAsk:exec from sym where askcount < 10

