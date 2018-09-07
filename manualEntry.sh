clear

echo -n "Enter the Partner Name : "; read pName
echo -n "Enter the default routing id : "; read dRoutingId
echo ""
echo "Enter the contact info : "
echo -n "Enter the primary contact name : "; read name
echo -n "Enter the email id : "; read eid;
echo -n "Enter the phone number : "; read phone

mkdir ./AddPartner/"$pName"

sed "s/PARTNERNAME/$pName/;s/DEFAULTROUTINGID/$dRoutingId/;s/PRIMARYNAME/$name/;s/EMAILADDRESS/$eid/;s/PHONENUMBER/$phone/" ./conf/addPartner.json > ./AddPartner/"$pName"/"$pName".json

#java -jar AddPartner.jar $pName $dRoutingId $name $eid $phone 

URL="http://10.151.14.55:6080/api"

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "admin:Axway123" \
-X POST --data @./AddPartner/"$pName"/"$pName".json "$URL/v1/tradingPartners" | python -m json.tool > ./AddPartner/"$pName"/"$pName"_response.json 

if grep -q "ERROR" ./AddPartner/"$pName"/"$pName"_response.json
then
clear
printf "%*s\n" $[$(tput cols)/2] "ERROR: Partner $pName could not be added. Check the response file for more details."
sleep 3
#rm -rf ./AddPartner/"$pName"
clear
exit
else
clear
printf "%*s\n" $[$(tput cols)/2] "Partner $pName added successfully"
sleep 3
clear
fi

echo -n "Do you wish to subscribe partner $pName to the existing community ? (y/n) : "
read choice
if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
clear
echo -n "Enter the Community name : "
read community

curl -u "admin:Axway123" -X GET "$URL/v1/communities" | python -m json.tool > ./conf/communityResponse.json

SUBSCRIPTION=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetId PARTNER $pName subscribedCommunities`

COM_ID=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetId COMMUNITY $community @id`

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "admin:Axway123" \
-X POST "$URL$SUBSCRIPTION?communityId=$COM_ID" | python -m json.tool > ./AddPartner/"$pName"/"$pName"_subscriptionResponse.json

clear
printf "%*s\n" $[$(tput cols)/2] "Partner $pName successfully subscribed to $community community."
sleep 3 

fi


echo -n "Do you wish to add partner delivery ? (y/n) : "
read choice

if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
clear
echo "Please enter the partner delivery details : "
echo -n "Enter the AS2 URL : "
read url 

ID=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetId PARTNER $pName tradingDeliveryExchanges`

sed -n '/<!-- AS2 Details Begin-->/,/<!-- AS2 Details End-->/p' conf/addPartnerExchangePoint.json | sed '1d;$d' > ./AddPartner/"$pName"/"$pName"_deliveryExchange.json
sed -i "s/PARTNERNAME/$pName/;s|URL|$url|" ./AddPartner/"$pName"/"$pName"_deliveryExchange.json

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "admin:Axway123" \
-X POST --data @./AddPartner/"$pName"/"$pName"_deliveryExchange.json "$URL$ID" | python -m json.tool > ./AddPartner/"$pName"/"$pName"_deliveryExchangeResponse.json

clear
printf "%*s\n" $[$(tput cols)/2] "Partner Delivery added successfully"
sleep 2
else
clear
echo
printf "%*s\n" $[$(tput cols)/2] "Thank you for using this automation tool. "
fi

rm -rf ./AddPartner/"$pName"
