\p 0W
system"l C:/Users/cloug/Documents/kdb/plantGit/schema.q"

/get username
optionCheck["-user";"username";"bot"];

/open port for rdb
rdbH:conLog["rdb";username;"pass"]

/open port for BB
bbH:conLog["BB";username;"pass"]

/how to get tables
getMe:{[tableName]rdbH tableName}
/place orders
placeOrder:{[side;ticker;val;ammount]bbH(insert;side;.z.P,ticker,val,ammount,`$username)}
/countthe number of null spaces
tLen:{[tableName]rdbH "getTableLen[\"",tableName,"\"]";show rdbH stockCount}

tLen1:{[tableName]rdbH (`getTableLen;tableName);rdbH `stockCount}
ucb:{[stock;tableName]rdbH (`cbid;stock;tableName) }
uca:{[stock;tableName]rdbH (`cask;stock;tableName) }

/autoFill:{[sym]}'[rdbH symBid;]

/gets all the lowest bids and highest asks
/lowBA:(select last bid by ticker from getMe["BA"] where not bid =0Nf)  ujf select last ask by ticker from getMe["BA"] where not ask=0Wf

show "logged in"

-1"-----NOTICE FOR USE-----\ngetMe[`tableName] for tables\nplaceOrder[`side;`ticker;price;ammount] to place orders";
-1"number of each stock tLen[`stock;`tableName]";

