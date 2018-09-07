SUBSCRIPTION=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetPartnerDetails PARTNER ${a[1]} subscribedCommunities`

COM_ID=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetId COMMUNITY ${a[6]} @id`

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "$B2BIUSER:$B2BIPASS" \
-X POST "$URL$SUBSCRIPTION?communityId=$COM_ID" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_subscriptionResponse.json

printf "%*s\n" $[$(tput cols)/2] "Partner ${a[1]} successfully subscribed to ${a[6]} community."

