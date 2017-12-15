/get all the trade dates and prices of the last trades
c:select last date:tradedate,last price by sym:ticker from tradeArc

/get all the syms that haven't been traded yet
cE:select last date,last price by sym from realStock where not sym in exec ticker from tradeArc

cur:c,cE

`sym xasc `cur