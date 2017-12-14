\p 0W
system"l C:/Users/cloug/Documents/kdb/plantGit/schema.q"
system"l ",DIR,"tables.q"
system"l ",DIR,"netLog.q"
system"l ",DIR,"users.q"

/load the stock table to work with
system"l ",DIR,"get_FTSE.q"

/saving the port number to a binary file
prt:system"p"
`:BB.port set prt

/check who is logging in
permis:{[user;pass]access::min (uBB[user]~pass; not user~""; not pass~"");access}

tickers:([]stocks:`VOD`BAE;prices:10 20);
update varince:prices*0.1 from `tickers
if[1 = count tickers;tickers:enlist tickers]
length:10

fillTables:{[table;timeAdd;ticker;price;volume;user]table insert timeAdd,ticker,price,volume,user}
perStock:{[stocks;prices;varince]
	fillTables'[`ask ; .z.p; length#stocks;prices+varince-length?3*varince;1000+length?10000;`startup];
	fillTables'[`bid ; .z.p; length#stocks;prices-varince+length?3*varince;1000+length?10000;`startup];
 }
perStock'[tickers.stocks;tickers.prices;tickers.varince]


getSide:{[BA]$[0 < exec bidvol-askvol from BA;side::1;
		0 > exec bidvol-askvol from BA;side::2;
		side::0
	 ];}

updateTables:{[BA;updateT;clearT;minMax;stock]
	$[`ask~updateT;
		(`tradeHist insert .z.p, value exec ticker,tradeVol:bidvol,0.5*bid+ask,biduser,askuser  from BA;
		`ask insert value exec biddate,ticker,ask, abs bidvol - askvol,askuser from BA;);
		(`tradeHist insert .z.p, value exec ticker,tradeVol:askvol,0.5*bid+ask,biduser,askuser  from BA;
		`bid insert value exec biddate,ticker,bid, abs bidvol - askvol,biduser from BA)
		];
	/top will empty
	clearT insert 0Np,stock,minMax,0N,`;
	
	/delete now used top row
	rowOneBid:first exec i from bid where ticker=stock;
	rowOneAsk:first exec i from ask where ticker=stock;
	delete from `bid where i=rowOneBid;
	delete from `ask where i=rowOneAsk;
	
	/re-sort
	`ask xasc `ask;
	`bid xdesc `bid;
	/sort by ticker
	`ticker xasc `bid;
	`ticker xasc `ask;
	}
	 
func:{[bid;ask;stock]
	/put togther and look at top row
	BA:first select from bid^ask where ticker=stock;
	/side 1 is ask is the smaller volume, 2 is bid, 0 is matched
	getSide[BA];
	$[1~side;updateTables[BA;`bid ; `ask ; 0Wf;stock];
		2~side;updateTables[BA;`ask ; `bid ; 0Nf;stock];
		show side
	 ];
 }

fixLength:{[stock]
	/sort by price
	`ask xasc `ask;
	`bid xdesc `bid;
	/sort by ticker
	`ticker xasc `bid;
	`ticker xasc `ask;
	/make sure there are only ten in each row
	while[10 < count select from bid where ticker=stock; delete from `bid where ticker=stock,i=last i;];
	while[10 < count select from ask where ticker=stock; delete from `ask where ticker=stock,i=last i;];
 }
 
makeTrade:{[stock]
	/solve the table for till all possible trades ahve been made
	while[0 <= first exec bid - ask from bid^ask where ticker=stock;
		func[bid;ask;stock]
	 ];
 }
 
.z.ts:{subfind["fh*"];
	fixLength'[tickers.stocks];
	makeTrade'[tickers.stocks];
	sendData[UPD;neg subs;`BA;bid^ask];
	sendData[UPD;neg subs;`tradeHist;tradeHist];
	tradeArc::tradeArc,tradeHist;
	delete from `tradeHist
 }
\t 0

