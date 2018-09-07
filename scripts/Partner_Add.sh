mkdir AddPartner/"${a[1]}"

sed "s/PARTNERNAME/${a[1]}/;s/DEFAULTROUTINGID/${a[2]}/;s/PRIMARYNAME/${a[3]}/;s/EMAILADDRESS/${a[4]}/;s/PHONENUMBER/${a[5]}/" ./conf/addPartner.json > ./AddPartner/"${a[1]}"/"${a[1]}".json

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "admin:Axway123" \
-X POST --data @./AddPartner/"${a[1]}"/"${a[1]}".json "$URL/v1/tradingPartners" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_response.json

if grep -q "A Trading partner named '${a[1]}' already exists." ./AddPartner/"${a[1]}"/"${a[1]}"_response.json
then

ROUTINGID=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetPartnerDetails PARTNER ${a[1]} routingIds`

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "admin:Axway123" \
-X POST --data '{ "routingId": "'${a[2]}'" }' "$URL$ROUTINGID" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_routingid_response.json

sed -n "${count}s/$/SUCCESS,/p" ./input/in.csv >> ./output/out.csv
clear
fi

if grep -q "This routing ID already exists." ./AddPartner/"${a[1]}"/"${a[1]}"_response.json
then
printf "%*s\n" $[$(tput cols)/2] "Duplicate routing id."
sed -n "${count}s/$/FAILED,/p" ./input/in.csv >> ./output/out.csv
continue
else
sed -n "${count}s/$/SUCCESS,/p" ./input/in.csv >> ./output/out.csv
fi
