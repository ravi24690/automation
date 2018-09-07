curl -u "admin:Axway123" -X GET "$URL/v1/components" | python -m json.tool > conf/componentsResponse.json

COMP_ID=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetId COMPONENTS "${a[16]}" @id`

sed "s/SERVICENAME/${a[17]}/;s/COMPONENTID/$COMP_ID/" conf/addServices.json > ./AddPartner/"${a[1]}"/"${a[1]}"_services.json

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "$B2BIUSER:$B2BIPASS" \
-X POST --data @./AddPartner/"${a[1]}"/"${a[1]}"_services.json "$URL/v1/services" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_servicesResponse.json

printf "%*s\n" $[$(tput cols)/2] "Service added"
