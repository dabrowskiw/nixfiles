# from commonName of output of sudo bash extract.sh
IDENTITY='3690333713319584911@easyroam-pca.htw-berlin.de'

sudo nmcli connection add \
  type wifi \
  con-name easyroam-test \
  ssid eduroam \
  wifi-sec.key-mgmt wpa-eap \
  802-1x.eap tls \
  802-1x.identity "$IDENTITY" \
  802-1x.ca-cert /etc/easyroam/ca.pem \
  802-1x.client-cert /etc/easyroam/client.pem \
  802-1x.private-key /etc/easyroam/client.key \
  802-1x.private-key-password-flags 4 \
  802-1x.altsubject-matches "DNS:easyroam.eduroam.de"

sudo install -d \
  -o wpa_supplicant -g wpa_supplicant -m 700 \
  /etc/wpa_supplicant/easyroam

sudo install \
  -o wpa_supplicant -g wpa_supplicant -m 600 \
  /etc/easyroam/ca.pem \
  /etc/easyroam/client.pem \
  /etc/easyroam/client.key \
  /etc/wpa_supplicant/easyroam/

sudo nmcli connection modify easyroam-test \
  802-1x.ca-cert /etc/wpa_supplicant/easyroam/ca.pem \
  802-1x.client-cert /etc/wpa_supplicant/easyroam/client.pem \
  802-1x.private-key /etc/wpa_supplicant/easyroam/client.key

