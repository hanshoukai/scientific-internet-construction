#!/bin/bash
apt update && apt install wget openssl
mkdir hysteria && cd hysteria
wget https://github.com/apernet/hysteria/releases/download/v1.3.3/hysteria-linux-amd64
chmod +x hysteria-linux-amd64
openssl ecparam -genkey -name prime256v1 -out ca.key
openssl req -new -x509 -days 36500 -key ca.key -out ca.crt  -subj "/C=CN/CN=cn.bing.com"
touch config.json
cat <<EOF > config.json
{
    "listen":":9527",
    "cert":"/root/hysteria/ca.crt",
    "key":"/root/hysteria/ca.key",
    "obfs":"FfiYTOIQ8JELrn40"
}
EOF
ufw allow 9527
nohup ./hysteria-linux-amd64 server > hysteria.log 2>&1 &
ps -ef |grep hy*
