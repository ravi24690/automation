
CERT=`java -cp classes:jar/fasterxml-core.jar:jar/fasterxml-databind.jar:jar/jackson-annotations-2.1.2.jar:jar/json-simple-1.1.jar com.partner.GetPartnerDetails PARTNER ${a[1]} publicCertificates`

curl \
-H 'accept: application/json' \
-H 'content-type: application/octet-stream' \
-u "$B2BIUSER:$B2BIPASS" \
-X PUT --data-binary  @"${a[8]}" "$URL$CERT/import" | python -m json.tool > ./AddPartner/"${a[1]}"/"${a[1]}"_certificateResponse.json

printf "%*s\n" $[$(tput cols)/2] "Public certificate installed for partner ${a[1]}."
