\p 0W
system"l C:/Users/cloug/Documents/kdb/plantGit/schema.q"

/get username
optionCheck["-user";"username";program];

/open port for rdb
rdbH:conLog["rdb";username;"pass"]

/open port for BB
bbH:conLog["BB";username;"pass"]

/how to get tables
getMe:{[tableName]show rdbH tableName}
/place orders
placeOrder:{[side;ticker;val;ammount]bbH(insert;side;.z.P,ticker,val,ammount,`$username)}
/countthe number of null spaces
ucb:{[tableName]rdbH "cbid[`",tableName,"]" }
uca:{[tableName]rdbH "cask[`",tableName,"]" }
show "logged in"

-1"-----NOTICE FOR USE-----\ngetMe[\"tableName\"] for tables\nplaceOrder[`side;`ticker;price;ammount] to place orders";
-1"ucb[\"tableName\"]/uca[\"tableName\"] for the number of bids/asks in a table";