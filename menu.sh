#!/bin/bash

while true; do
    clear
    echo "==================================="
    echo "           MENU UTAMA"
    echo "        Script Mod By SL"
    echo "==================================="
    echo "1.  SSH & OpenVPN MENU"
    echo "2.  L2TP MENU"
    echo "3.  PPTP MENU"
    echo "4.  SSTP MENU"
    echo "5.  WIREGUARD MENU"
    echo "6.  SHADOWSOCKS MENU"
    echo "7.  SHADOWSOCKSR MENU"
    echo "8.  XRAY VMESS MENU"
    echo "9.  XRAY VLESS MENU"
    echo "10. XRAY TROJAN MENU"
    echo "11. TROJAN GO MENU"
    echo "12. XRAY GRPC MENU"
    echo "13. SLOWDNS MENU (OFF)"
    echo "14. CEK SEMUA IP PORT"
    echo "15. CEK SEMUA SERVICE VPN"
    echo "16. UPDATE MENU (Update)"
    echo "17. sl-fix (Perbaiki Error SSLH+WS-TLS setelah reboot)"
    echo "18. Settings (Pengaturan)"
    echo "19. Exit (Keluar)"
    echo "20. copyrepo (Salin Repo Script Mantap)"
    echo "21. menuinfo (Untuk Mendapatkan Informasi)"
    echo "22. Shadowsocks Plugin (Buat Akun)"
    echo "==================================="
    read -p "Pilih menu [1-22]: " pilihan

    case $pilihan in
        1) echo "🔹 Membuka SSH & OpenVPN Menu..."; sleep 2; ./ssh-openvpn-menu.sh ;;
        2) echo "🔹 Membuka L2TP Menu..."; sleep 2; ./l2tp-menu.sh ;;
        3) echo "🔹 Membuka PPTP Menu..."; sleep 2; ./pptp-menu.sh ;;
        4) echo "🔹 Membuka SSTP Menu..."; sleep 2; ./sstp-menu.sh ;;
        5) echo "🔹 Membuka WireGuard Menu..."; sleep 2; ./wireguard-menu.sh ;;
        6) echo "🔹 Membuka Shadowsocks Menu..."; sleep 2; ./shadowsocks-menu.sh ;;
        7) echo "🔹 Membuka ShadowsocksR Menu..."; sleep 2; ./shadowsocksr-menu.sh ;;
        8) echo "🔹 Membuka XRay VMESS Menu..."; sleep 2; ./xray-vmess-menu.sh ;;
        9) echo "🔹 Membuka XRay VLESS Menu..."; sleep 2; ./xray-vless-menu.sh ;;
        10) echo "🔹 Membuka XRay Trojan Menu..."; sleep 2; ./xray-trojan-menu.sh ;;
        11) echo "🔹 Membuka Trojan Go Menu..."; sleep 2; ./trojan-go-menu.sh ;;
        12) echo "🔹 Membuka XRay gRPC Menu..."; sleep 2; ./xray-grpc-menu.sh ;;
        13) echo "🔹 SlowDNS belum tersedia!"; sleep 2 ;;
        14) echo "🔹 Cek semua IP & Port..."; sleep 2; netstat -tulnp ;;
        15) echo "🔹 Cek semua service VPN..."; sleep 2; systemctl list-units --type=service | grep -E 'xray|trojan|ssh|openvpn|wireguard' ;;
        16) echo "🔹 Mengemaskini script..."; sleep 2; git pull origin main ;;
        17) echo "🔹 Memperbaiki SSLH & WS-TLS..."; sleep 2; systemctl restart sslh ;;
        18) echo "🔹 Membuka pengaturan..."; sleep 2; nano /etc/config-vpn.conf ;;
        19) echo "🔹 Keluar dari menu"; exit ;;
        20) echo "🔹 Menyalin repo script..."; sleep 2; git clone https://github.com/rAzAkShArKTaURuS7/setup-vpn.git ;;
        21) echo "🔹 Menampilkan informasi..."; sleep 2; cat /etc/vpn-info.txt ;;
        22) echo "🔹 Membuat Shadowsocks Plugin..."; sleep 2; ./shadowsocks-plugin.sh ;;
        *) echo "❌ Pilihan tidak valid!"; sleep 2 ;;
    esac
done
