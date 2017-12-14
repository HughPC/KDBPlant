-1"make sure you run ./FTSEget.sh first!!!";

realStock:("pssff";",") 0:`FTSE.out

realStock: flip `date`sym`name`price`change!realStock

realStock:select from realStock where price > 0;
