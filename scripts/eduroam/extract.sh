P12="nixmobile.p12"

sudo install -d -m 700 /etc/easyroam

sudo openssl pkcs12 \
  -legacy \
  -in "$P12" -passin pass: \
  -clcerts -nokeys \
  -out /etc/easyroam/client.pem

sudo openssl pkcs12 \
  -legacy \
  -in "$P12" -passin pass: \
  -cacerts -nokeys \
  -out /etc/easyroam/ca.pem

sudo openssl pkcs12 \
  -legacy \
  -in "$P12" -passin pass: \
  -nocerts -nodes \
  -out /etc/easyroam/client.key

sudo chmod 600 /etc/easyroam/*

sudo openssl x509 \
  -in /etc/easyroam/client.pem \
  -noout -subject -dates -nameopt multiline
