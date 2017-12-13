\p 0W
\l c:/Users/cloug/Documents/kdb/plant/schema.q
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
/TODO get the stocks to filter by
getTick:{[tableName]stocks::distinct value tableName,".ticker"}
stockCount:([]ticker:stocks;askcount:cask'[stocks;`BA];bidcount:cbid'[stocks;`BA])
cbid:{[stock;tableName]count select from tableName where not biddate=0Np,ticker=stock}
cask:{[stock;tableName]count select from tableName where not askdate=0Np,ticker=stock}