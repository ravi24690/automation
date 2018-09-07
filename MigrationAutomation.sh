#!/bin/bash

SECONDS=0

touch ./output/out.csv
rm ./output/out.csv

#java -cp classes:jar/ojdbc7.jar com.partner.DBRetrieval

URL="http://10.151.14.55:6080/api"
B2BIUSER="admin"
B2BIPASS="Axway123"
echo "Hi"
count=0
while read line
do
count=`expr $count + 1`
clear
echo "Hello"
for i in $(seq 1 15)
do
a[i]=`echo $line | cut -d',' -f$i`
done

if [ "${a[7]}" == "Gateway ROSETTANET-HTTP client" ] || [ "${a[7]}" == "Gateway ROSETTANET-HTTP server" ] || [ "${a[7]}" == "Gateway AS2 client" ] || [ "${a[7]}" == "Gateway AS2 server" ] || [ "${a[7]}" == "Gateway OFTP" ]
then
echo "Good to proceed"
else 
sed -n "${count}s/$/NoScope,/p" ./input/in.csv >> ./output/out.csv
sleep 2
continue
fi

if [ "${a[1]}" == "null" ]
then
printf "%*s\n" $[$(tput cols)/2] "No Partner to add."
sleep 1
continue
else
curl -u "admin:Axway123" -X GET "$URL/v1/tradingPartners?limit=40" | python -m json.tool > conf/partnerResponse.json
. ./scripts/Partner_Add.sh
curl -u "admin:Axway123" -X GET "$URL/v1/tradingPartners?limit=40" | python -m json.tool > conf/partnerResponse.json
fi

if [ "${a[6]}" != "null" ]
then
curl -u "admin:Axway123" -X GET "$URL/v1/communities" | python -m json.tool > conf/communityResponse.json
. ./scripts/Community_Subscribe.sh
fi


if [ "${a[8]}" != "null" ]
then
. ./scripts/Partner_Certificate.sh
fi


if [ "${a[7]}" != "null" ]
then
. ./scripts/Partner_Delivery.sh
fi

<<COMMENT1
if [ "${a[16]}" != "null" ]
then
. ./scripts/Add_Components.sh
fi

if [ "${a[17]}" != "null" ]
then
. ./scripts/Add_Services.sh
fi
COMMENT1

rm -rf ./AddPartner/"${a[1]}"

done < ./input/in.csv

clear

count=`cat input/in.csv | wc -l`
duration=$SECONDS
echo -e "\x1b[32;40mMigration of $count parnter took $(($duration / 60)) minutes and $(($duration % 60)) seconds. \x1b[m"
sleep 3

