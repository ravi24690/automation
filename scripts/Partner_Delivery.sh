
if [ "${a[7]}" == "Gateway AS2 server" ] || [ "${a[7]}" == "Gateway ROSETTANET-HTTP server" ]
then

PDELIVERY=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetPartnerDetails PARTNER ${a[1]} tradingDeliveryExchanges`

sed -n '/<!-- AS2 Details Begin-->/,/<!-- AS2 Details End-->/p' conf/addPartnerExchangePoint.json | sed '1d;$d' > ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json

if [ "${a[10]}" != "null" ]
then
sed -i "s/ROUTINGID/${a[2]}/;s|URL|${a[9]}${a[10]}|" ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json
else
sed -i "s/ROUTINGID/${a[2]}/;s|URL|${a[9]}|" ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json
fi

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "$B2BIUSER:$B2BIPASS" \
-X POST --data @./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json "$URL$PDELIVERY" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchangeResponse.json

printf "%*s\n" $[$(tput cols)/2] "Partner Delivery added successfully"

elif [ "${a[7]}" == "SFTP" ]
then

PDELIVERY=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetPartnerDetails PARTNER ${a[1]} tradingDeliveryExchanges`

sed -n '/<!-- SFTP Details Begin-->/,/<!-- SFTP Details End-->/p' conf/addPartnerExchangePoint.json | sed '1d;$d' > ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json
sed -i "s/PARTNERNAME/${a[1]}/;s/SFTPUSERNAME/${a[10]}/;s/SFTPPASSWORD/${a[11]}/;s/SFTPHOSTNAME/${a[12]}/;s/SFTPPORT/${a[13]}/;s|SFTPDIRECTORY|${a[14]}|;s|SSHKEYS|${a[15]}|" ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "$B2BIUSER:$B2BIPASS" \
-X POST --data @./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json "$URL$PDELIVERY" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchangeResponse.json

printf "%*s\n" $[$(tput cols)/2] "Partner Delivery added successfully"

elif [ "${a[7]}" == "FTP" ]
then

PDELIVERY=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetPartnerDetails PARTNER ${a[1]} tradingDeliveryExchanges`

sed -n '/<!-- FTP Details Begin-->/,/<!-- FTP Details End-->/p' conf/addPartnerExchangePoint.json | sed '1d;$d' > ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json
sed -i "s/PARTNERNAME/${a[1]}/;s/FTPUSERNAME/${a[10]}/;s/FTPPASSWORD/${a[11]}/;s/FTPHOSTNAME/${a[12]}/;s/FTPPORT/${a[13]}/;s|FTPDIRECTORY|${a[14]}|" ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "$B2BIUSER:$B2BIPASS" \
-X POST --data @./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json "$URL$PDELIVERY" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchangeResponse.json

printf "%*s\n" $[$(tput cols)/2] "Partner Delivery added successfully"

elif [ "${a[7]}" == "FILESYSTEM" ]
then

PDELIVERY=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetPartnerDetails PARTNER ${a[1]} tradingDeliveryExchanges`

sed -n '/<!-- FILESYSTEM Details Begin-->/,/<!-- FILESYSTEM Details End-->/p' conf/addPartnerExchangePoint.json | sed '1d;$d' > ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json
sed -i "s/PARTNERNAME/${a[1]}/;s|FILESYSTEMDIRECTORY|${a[14]}|" ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json
 
curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "$B2BIUSER:$B2BIPASS" \
-X POST --data @./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchange.json "$URL$PDELIVERY" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_deliveryExchangeResponse.json

printf "%*s\n" $[$(tput cols)/2] "Partner Delivery added successfully"

fi
