rm -rf xray
clear
NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
secs_to_human() {
echo -e "${WB}Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds${NC}"
}
start=$(date +%s)
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install socat netfilter-persistent -y
apt install vnstat lsof fail2ban -y
apt install curl sudo -y
apt install screen cron screenfetch -y
mkdir /backup >> /dev/null 2>&1
mkdir /user >> /dev/null 2>&1
mkdir /tmp >> /dev/null 2>&1
apt install resolvconf network-manager dnsutils bind9 -y
cat > /etc/systemd/resolved.conf << END
[Resolve]
DNS=8.8.8.8 8.8.4.4
Domains=~.
ReadEtcHosts=yes
END
systemctl enable resolvconf
systemctl enable systemd-resolved
systemctl enable NetworkManager
rm -rf /etc/resolv.conf
rm -rf /etc/resolvconf/resolv.conf.d/head
echo "
nameserver 127.0.0.53
" >> /etc/resolv.conf
echo "
" >> /etc/resolvconf/resolv.conf.d/head
systemctl restart resolvconf
systemctl restart systemd-resolved
systemctl restart NetworkManager
echo "Google DNS" > /user/current
rm /usr/local/etc/xray/city >> /dev/null 2>&1
rm /usr/local/etc/xray/org >> /dev/null 2>&1
rm /usr/local/etc/xray/timezone >> /dev/null 2>&1
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" - install --beta
cp /usr/local/bin/xray /backup/xray.official.backup
curl -s ipinfo.io/city >> /usr/local/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /usr/local/etc/xray/org
curl -s ipinfo.io/timezone >> /usr/local/etc/xray/timezone
clear
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Xray-core mod${NC}"
sleep 0.5
wget -q -O /backup/xray.mod.backup "https://github.com/dharak36/Xray-core/releases/download/v1.0.0/xray.linux.64bit"
echo -e "${GB}[ INFO ]${NC} ${WB}Download Xray-core done${NC}"
sleep 1
cd
clear
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest
clear
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install nginx -y
rm /var/www/html/*.html
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mkdir -p /var/www/html/vmess
mkdir -p /var/www/html/vless
mkdir -p /var/www/html/trojan
mkdir -p /var/www/html/shadowsocks
mkdir -p /var/www/html/shadowsocks2022
mkdir -p /var/www/html/socks5
mkdir -p /var/www/html/allxray
systemctl restart nginx
clear
touch /usr/local/etc/xray/domain
echo -e "${WB}Input Domain${NC} "
echo " "
read -rp "Input domain kamu : " -e dns
if [ -z $dns ]; then
echo -e "Nothing input for domain!"
else
echo "$dns" > /usr/local/etc/xray/domain
echo "DNS=$dns" > /var/lib/dnsvps.conf
fi
clear
systemctl stop nginx
systemctl stop xray
domain=$(cat /usr/local/etc/xray/domain)
curl https://get.acme.sh | sh
source ~/.bashrc
cd .acme.sh
bash acme.sh --issue -d $domain --server letsencrypt --keylength ec-256 --fullchain-file /usr/local/etc/xray/fullchain.crt --key-file /usr/local/etc/xray/private.key --standalone --force
clear
echo -e "${GB}[ INFO ]${NC} ${WB}Setup Nginx & Xray Conf${NC}"
echo "UQ3w2q98BItd3DPgyctdoJw4cqQFmY59ppiDQdqMKbw=" > /usr/local/etc/xray/serverpsk
wget -q -O /usr/local/etc/xray/config.json https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/config.json
wget -q -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/nginx.conf
wget -q -O /etc/nginx/conf.d/xray.conf https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/xray.conf
systemctl restart nginx
systemctl restart xray
echo -e "${GB}[ INFO ]${NC} ${WB}Setup Done${NC}"
sleep 2
clear
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
cd /usr/bin
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Main Menu${NC}"
wget -q -O menu "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/menu.sh"
wget -q -O vmess "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/vmess.sh"
wget -q -O vless "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/vless.sh"
wget -q -O trojan "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/trojan.sh"
wget -q -O shadowsocks "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/shadowsocks.sh"
wget -q -O shadowsocks2022 "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/shadowsocks2022.sh"
wget -q -O socks "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/socks.sh"
wget -q -O allxray "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/allxray.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Menu Vmess${NC}"
wget -q -O add-vmess "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/add-vmess.sh"
wget -q -O del-vmess "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/del-vmess.sh"
wget -q -O extend-vmess "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/extend-vmess.sh"
wget -q -O trialvmess "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/trialvmess.sh"
wget -q -O cek-vmess "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/cek-vmess.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Menu Vless${NC}"
wget -q -O add-vless "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/add-vless.sh"
wget -q -O del-vless "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/del-vless.sh"
wget -q -O extend-vless "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/extend-vless.sh"
wget -q -O trialvless "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/trialvless.sh"
wget -q -O cek-vless "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/cek-vless.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Menu Trojan${NC}"
wget -q -O add-trojan "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/add-trojan.sh"
wget -q -O del-trojan "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/del-trojan.sh"
wget -q -O extend-trojan "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/extend-trojan.sh"
wget -q -O trialtrojan "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/trialtrojan.sh"
wget -q -O cek-trojan "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/cek-trojan.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Menu Shadowsocks${NC}"
wget -q -O add-ss "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/add-ss.sh"
wget -q -O del-ss "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/del-ss.sh"
wget -q -O extend-ss "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/extend-ss.sh"
wget -q -O trialss "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/trialss.sh"
wget -q -O cek-ss "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/cek-ss.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Menu Shadowsocks 2022${NC}"
wget -q -O add-ss2022 "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/add-ss2022.sh"
wget -q -O del-ss2022 "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/del-ss2022.sh"
wget -q -O extend-ss2022 "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/extend-ss2022.sh"
wget -q -O trialss2022 "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/trialss2022.sh"
wget -q -O cek-ss2022 "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/cek-ss2022.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Menu Socks5${NC}"
wget -q -O add-socks "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/add-socks.sh"
wget -q -O del-socks "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/del-socks.sh"
wget -q -O extend-socks "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/extend-socks.sh"
wget -q -O trialsocks "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/trialsocks.sh"
wget -q -O cek-socks "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/cek-socks.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Menu All Xray${NC}"
wget -q -O add-xray "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/add-xray.sh"
wget -q -O del-xray "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/del-xray.sh"
wget -q -O extend-xray "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/extend-xray.sh"
wget -q -O trialxray "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/trialxray.sh"
wget -q -O cek-xray "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/cek-xray.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Menu Log${NC}"
wget -q -O log-create "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/log-create.sh"
wget -q -O log-vmess "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/log-vmess.sh"
wget -q -O log-vless "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/log-vless.sh"
wget -q -O log-trojan "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/log-trojan.sh"
wget -q -O log-ss "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/log-ss.sh"
wget -q -O log-ss2022 "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/log-ss2022.sh"
wget -q -O log-socks "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/log-socks.sh"
wget -q -O log-allxray "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/log-allxray.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${WB}Downloading Other Menu${NC}"
wget -q -O xp "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/xp.sh"
wget -q -O dns "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/dns.sh"
wget -q -O certxray "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/certxray.sh"
wget -q -O xraymod "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/xraymod.sh"
wget -q -O xrayofficial "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/xrayofficial.sh"
wget -q -O about "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/about.sh"
wget -q -O clear-log "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/clear-log.sh"
wget -q -O changer "https://raw.githubusercontent.com/GnrlKyy/AS_XRAY/main/changer.sh"
echo -e "${GB}[ INFO ]${NC} ${WB}Download All Menu Done${NC}"
sleep 2
chmod +x add-vmess
chmod +x del-vmess
chmod +x extend-vmess
chmod +x trialvmess
chmod +x cek-vmess
chmod +x add-vless
chmod +x del-vless
chmod +x extend-vless
chmod +x trialvless
chmod +x cek-vless
chmod +x add-trojan
chmod +x del-trojan
chmod +x extend-trojan
chmod +x trialtrojan
chmod +x cek-trojan
chmod +x add-ss
chmod +x del-ss
chmod +x extend-ss
chmod +x trialss
chmod +x cek-ss
chmod +x add-ss2022
chmod +x del-ss2022
chmod +x extend-ss2022
chmod +x trialss2022
chmod +x cek-ss2022
chmod +x add-socks
chmod +x del-socks
chmod +x extend-socks
chmod +x trialsocks
chmod +x cek-socks
chmod +x add-xray
chmod +x del-xray
chmod +x extend-xray
chmod +x trialxray
chmod +x cek-xray
chmod +x log-create
chmod +x log-vmess
chmod +x log-vless
chmod +x log-trojan
chmod +x log-ss
chmod +x log-ss2022
chmod +x log-socks
chmod +x log-allxray
chmod +x menu
chmod +x vmess
chmod +x vless
chmod +x trojan
chmod +x shadowsocks
chmod +x shadowsocks2022
chmod +x socks
chmod +x allxray
chmod +x xp
chmod +x dns
chmod +x certxray
chmod +x xraymod
chmod +x xrayofficial
chmod +x about
chmod +x clear-log
chmod +x changer
cd
echo "0 0 * * * root xp" >> /etc/crontab
echo "*/3 * * * * root clear-log" >> /etc/crontab
systemctl restart cron
cat > /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
clear
echo ""
echo ""
echo -e "${GB}—————————————————————————————————————————————————————————${NC}"
echo -e "${BGG}                 ${WB}XRAY SCRIPT ESTEBAN_ZXX                 ${NC}"
echo -e "${GB}—————————————————————————————————————————————————————————${NC}"
echo -e "  ${WB}»»» Protocol Service «««  |  »»» Network Protocol «««${NC}  "
echo -e "${GB}—————————————————————————————————————————————————————————${NC}"
echo -e "  ${WB}- Vless${NC}                   ${WB}|${NC}  ${WB}- Websocket (CDN) non TLS${NC}"
echo -e "  ${WB}- Vmess${NC}                   ${WB}|${NC}  ${WB}- Websocket (CDN) TLS${NC}"
echo -e "  ${WB}- Trojan${NC}                  ${WB}|${NC}  ${WB}- gRPC (CDN) TLS${NC}"
echo -e "  ${WB}- Socks5${NC}                  ${WB}|${NC}"
echo -e "  ${WB}- Shadowsocks${NC}             ${WB}|${NC}"
echo -e "  ${WB}- Shadowsocks 2022${NC}        ${WB}|${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e "               ${WB}»»» Network Port Service «««${NC}             "
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${WB}- HTTPS : 443, 2053, 2083, 2087, 2096, 8443${NC}"
echo -e "  ${WB}- HTTP  : 80, 8080, 8880, 2052, 2082, 2086, 2095${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo ""
rm -f xray
secs_to_human "$(($(date +%s) - ${start}))"
echo -e "${WB}[ WARNING ] reboot now ? (Y/N)${NC} "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
