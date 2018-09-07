
sed "s|MAPNAME|${a[16]}|" ./conf/addComponents.json > ./AddPartner/"${a[1]}"/"${a[1]}"_components.json

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-u "$B2BIUSER:$B2BIPASS" \
-X POST --data @./AddPartner/"${a[1]}"/"${a[1]}"_components.json "$URL/v1/components" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_componentsResponse.json

printf "%*s\n" $[$(tput cols)/2] "Component added successfully"
