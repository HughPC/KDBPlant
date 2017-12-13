/buy table
bid:([]biddate:`timestamp$();ticker:`$();bid:"f"$();bidvol:"j"$();biduser:`$())

/sell table
ask:([]askdate:`timestamp$();ticker:`$();ask:"f"$();askvol:"j"$();askuser:`$())

/trade history 
tradeHist:([]tradedate:`timestamp$();ticker:`$();vol:"j"$();price:"f"$();biduser:`$();askuser:`$())

tradeArc:tradeHist

/making the table
/fakeNYSE:([]date:`timestamp$();ticker:`$();bid:();bidvol:();ask:();askvol:())

/fxtable
/fxExport:([]time:`timestamp$();currencyPair:`$();bid:"F"$();offer:"F"$();high:"F"$();low:"F"$();open:"F"$())