#!/bin/bash
# Auto-Setup VPN (XRay, VLESS, VMESS, Trojan, SSH WebSocket)
# Dibuat oleh Ainhoa | unblockvpn.store | Bug Host: youtu.be

# Pastikan script dijalankan sebagai root
if [ "$(id -u)" != "0" ]; then
   echo "Sila jalankan script ini sebagai root!"
   exit 1
fi

# Kemas kini & pasang pakej asas
echo "?? Mengemas kini sistem..."
apt update -y && apt upgrade -y
apt install -y curl wget nano unzip nginx git socat cron bash-completion certbot python3-certbot-nginx

# Pasang XRay Core
echo "⚡ Memasang XRay Core..."
bash <(curl -Ls https://raw.githubusercontent.com/XTLS/Xray-install/main/install-release.sh)

# Pasang Nginx untuk reverse proxy
echo "?? Mengkonfigurasi Nginx..."
rm -rf /etc/nginx/sites-enabled/default
cat > /etc/nginx/sites-available/unblockvpn << END
server {
    listen 80;
    server_name youtu.be;

    location / {
        proxy_pass https://unblockvpn.store;
        proxy_set_header Host unblockvpn.store;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
END
ln -s /etc/nginx/sites-available/unblockvpn /etc/nginx/sites-enabled/
systemctl restart nginx

# Pasang Let's Encrypt SSL
echo "?? Memasang SSL untuk domain unblockvpn.store..."
certbot certonly --nginx --non-interactive --agree-tos -m razaksharktaurus7@gmail.com -d unblockvpn.store

# Konfigurasi XRay (VLESS WS + TLS)
mkdir -p /etc/xray
UUID=$(uuidgen)
cat > /etc/xray/config.json << END
{
  "inbounds": [
    {
      "port": 443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "flow": "xtls-rprx-vision",
            "email": "user@vpn"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/xrayws"
        },
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/letsencrypt/live/unblockvpn.store/fullchain.pem",
              "keyFile": "/etc/letsencrypt/live/unblockvpn.store/privkey.pem"
            }
          ]
        }
      }
    }
  ]
}
END

# Restart servis
systemctl restart nginx
systemctl restart xray

# Paparkan maklumat VPN
echo "✅ Pemasangan selesai!"
echo "?? Bug Host: youtu.be"
echo "?? Domain: unblockvpn.store"
echo "?? UUID: $UUID"
echo "Gunakan bug host youtu.be dalam klien VPN anda."
