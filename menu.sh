BGG='\e[42m'
NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray_service == "running" ]]; then
status_xray="${GB}[ ON ]${NC}"
else
status_xray="${RB}[ OFF ]${NC}"
fi
if [[ $nginx_service == "running" ]]; then
status_nginx="${GB}[ ON ]${NC}"
else
status_nginx="${RB}[ OFF ]${NC}"
fi
dtoday="$(vnstat | grep today | awk '{print $2" "substr ($3, 1, 3)}')"
utoday="$(vnstat | grep today | awk '{print $5" "substr ($6, 1, 3)}')"
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}')"
dmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $2" "substr ($3, 1 ,3)}')"
umon="$(vnstat -m | grep `date +%G-%m` | awk '{print $5" "substr ($6, 1 ,3)}')"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}')"
domain=$(cat /usr/local/etc/xray/domain)
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
WKT=$(cat /usr/local/etc/xray/timezone)
DATE=$(date -R | cut -d " " -f -4)
MYIP=$(curl -sS ipv4.icanhazip.com)
clear
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e "${BGG}               ${WB}----- [ Xray Script ] -----              ${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e " ${WB}Service Provider${NC} ${WB}: $ISP"
echo -e " ${WB}Timezone${NC}         ${WB}: $WKT${NC}"
echo -e " ${WB}City${NC}             ${WB}: $CITY${NC}"
echo -e " ${WB}Date${NC}             ${WB}: $DATE${NC}"
echo -e " ${WB}Domain${NC}           ${WB}: $domain${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e "     ${WB}NGINX STATUS :${NC} $status_nginx    ${WB}XRAY STATUS :${NC} $status_xray   "
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e "${BGG}          ${WB}----- [ Bandwidth Monitoring ] -----          ${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e "    ${WB}Monthly ${GB}($(date +%B/%Y))${NC}      ${GB}↓↓ Down: $dmon${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e "${BGG}                ${WB}----- [ Xray Menu ] -----               ${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e " ${GB}[1]${NC} ${WB}Vmess Menu${NC}          ${GB}[5]${NC} ${WB}Shadowsocks 2022 Menu${NC}"
echo -e " ${GB}[2]${NC} ${WB}Vless Menu${NC}          ${GB}[6]${NC} ${WB}Socks5 Menu${NC}"
echo -e " ${GB}[3]${NC} ${WB}Trojan Menu${NC}         ${GB}[7]${NC} ${WB}All Xray Menu${NC}"
echo -e " ${GB}[4]${NC} ${WB}Shadowsocks Menu${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e "${BGG}                 ${WB}----- [ Utility ] -----                ${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e " ${GB}[8]${NC} ${WB}Log Create Account${NC}  ${GB}[13]${NC} ${WB}DNS Setting${NC}"
echo -e " ${GB}[9]${NC} ${WB}Speedtest${NC}           ${GB}[14]${NC} ${WB}Check DNS Status${NC}"
echo -e " ${GB}[10]${NC} ${WB}Change Domain${NC}      ${GB}[15]${NC} ${WB}Change Xray-core Mod${NC}"
echo -e " ${GB}[11]${NC} ${WB}Cert Acme.sh${NC}       ${GB}[16]${NC} ${WB}Change Xray-core Official${NC}"
echo -e " ${GB}[12]${NC} ${WB}About Script${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e ""
read -p " Select Menu :  "  opt
echo -e ""
case $opt in
1) clear ; vmess ;;
2) clear ; vless ;;
3) clear ; trojan ;;
4) clear ; shadowsocks ;;
5) clear ; shadowsocks2022 ;;
6) clear ; socks ;;
7) clear ; allxray ;;
8) clear ; log-create ;;
9) clear ; speedtest ;;
10) clear ; dns ;;
11) clear ; certxray ;;
12) clear ; about ;;
13) clear ; changer ;;
14) clear ;
resolvectl status
echo ""
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
echo ""
echo ""
menu ;;
15) clear ; xraymod ;;
16) clear ; xrayofficial ;;
x) exit ;;
*) echo -e "${WB}salah input${NC}" ; sleep 1 ; menu ;;
esac
