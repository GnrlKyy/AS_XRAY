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
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e "                  ${WB}Log Create User${NC}                   "
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e ""
echo -e " ${GB}[1]${NC} ${WB}Log Vmess Account${NC} "
echo -e " ${GB}[2]${NC} ${WB}Log Vless Account${NC} "
echo -e " ${GB}[3]${NC} ${WB}Log Trojan Account${NC} "
echo -e " ${GB}[4]${NC} ${WB}Log Shadowsocks Account${NC}"
echo -e " ${GB}[5]${NC} ${WB}Log Shadowsocks 2022 Account${NC}"
echo -e " ${GB}[6]${NC} ${WB}Log Socks5 Account${NC}"
echo -e " ${GB}[7]${NC} ${WB}Log All Xray Account${NC}"
echo -e ""
echo -e " ${GB}[0]${NC} ${WB}Back To Menu${NC}"
echo -e ""
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; log-vmess ; exit ;;
2) clear ; log-vless ; exit ;;
3) clear ; log-trojan ; exit ;;
4) clear ; log-ss ; exit ;;
5) clear ; log-ss2022 ; exit ;;
6) clear ; log-socks ; exit ;;
7) clear ; log-allxray ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo "salah tekan " ; sleep 0.5 ; log-create ;;
esac
