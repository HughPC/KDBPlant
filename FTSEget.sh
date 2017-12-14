#!/bin/bash

wget https://spreadsheets.google.com/feeds/list/0AhySzEddwIC1dEtpWF9hQUhCWURZNEViUmpUeVgwdGc/1/public/basic -O FTSE.log

sed -ri 's/<\/id>/\n/g' FTSE.log

sed -ri 's/.*<updated>([^Z]*).*>(.*L).*name:([^,]*).*price:([^,]*).*change:([^<]*).*/\1,\2,\3,\4,\5/g' FTSE.log

sed -ri 's/(....)-(..)-(..)T/\1.\2.\3D/' FTSE.log

grep -v "<" FTSE.log > FTSE.out
