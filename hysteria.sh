#!/bin/bash
apt update && apt install wget openssl
sleep 15
mkdir hysteria && cd hysteria
sleep 1
wget https://github.com/apernet/hysteria/releases/download/v1.3.4/hysteria-linux-amd64
sleep 10
chmod +x hysteria-linux-amd64
sleep 1
openssl ecparam -genkey -name prime256v1 -out ca.key
openssl req -new -x509 -days 36500 -key ca.key -out ca.crt  -subj "/C=CN/CN=cn.bing.com"
sleep 1
touch config.json
sleep 1
cat <<EOF > config.json
{
    "listen":":9527",
    "cert":"/root/hysteria/ca.crt",
    "key":"/root/hysteria/ca.key",
    "obfs":"FfiYTOIQ8JELrn40"
}
EOF
sleep 1
ufw allow 9527
sleep 1
nohup ./hysteria-linux-amd64 server > hysteria.log 2>&1 &
sleep 1
ps -ef |grep hyster*
