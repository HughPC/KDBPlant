#!/bin/bash

wget https://spreadsheets.google.com/feeds/list/0AhySzEddwIC1dEtpWF9hQUhCWURZNEViUmpUeVgwdGc/1/public/basic -O FTSE.log

sed -ri 's/<\/id>/\n/g' FTSE.log

sed -ri "s/.*>(.*L).*name:([^,]*).*price:([^,]*).*change:([^<]*).*/$(date +%Y.%m.%dD%H:%M:%s),\1,\2,\3,\4/g" FTSE.log

grep -v "<" FTSE.log > FTSE.out
