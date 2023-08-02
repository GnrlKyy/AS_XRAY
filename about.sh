#echo -e "\e[42mIni latar belakang hijau\e[0m"
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
read -n 1 -s -r -p "Press any key to back on menu"
menu
