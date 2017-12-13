\l C:\Users\cloug\Documents\kdb\plant\schema.q

/connecting to the data 
/optionCheck["-portFX";"portFX";0];
/connectionFX:`$"::",string portFX
/fx:hopen connectionFX
/tableImport:"fxExport"

/open port for tp
tpH:conLog["tp";program;"pass"]

/open port to where data is sent
bbH:conLog["BB";program;"pass"]

/show "was pushed table ",string query 1;
.z.ps:{[query]value query;tableSent::query 1; sendData[set;neg tpH; tableSent; value tableSent]; }

.z.ts:{show "Sent data";sendData[set;neg tp;tabledData]}
\t 0
