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
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e "${BGG}            ${WB}----- [ Shadowsocks Menu ] -----            ${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e " ${GB}[1]${NC} ${WB}Create Account Shadowsocks${NC} "
echo -e " ${GB}[2]${NC} ${WB}Trial Account Shadowsocks${NC} "
echo -e " ${GB}[3]${NC} ${WB}Extend Account Shadowsocks${NC} "
echo -e " ${GB}[4]${NC} ${WB}Delete Account Shadowsocks${NC} "
echo -e " ${GB}[5]${NC} ${WB}Check User Login${NC} "
echo -e " ${GB}[0]${NC} ${WB}Back To Menu${NC}"
echo -e "${GB}———————————————————————————————————————————————————————${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; add-ss ; exit ;;
2) clear ; trialss ; exit ;;
3) clear ; extend-ss ; exit ;;
4) clear ; del-ss ; exit ;;
5) clear ; cek-ss ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo -e "salah tekan " ; sleep 1 ; shadowsocks ;;
esac
