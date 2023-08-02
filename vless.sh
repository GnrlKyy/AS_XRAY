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
echo -e "${BGG}               ${WB}----- [ Vless Menu ] -----               ${NC}"
echo -e "${GB}————————————————————————————————————————————————————————${NC}"
echo -e " ${GB}[1]${NC} ${WB}Create Account Vless${NC} "
echo -e " ${GB}[2]${NC} ${WB}Trial Account Vless${NC} "
echo -e " ${GB}[3]${NC} ${WB}Extend Account Vless${NC} "
echo -e " ${GB}[4]${NC} ${WB}Delete Account Vless${NC} "
echo -e " ${GB}[5]${NC} ${WB}Check User Login${NC} "
echo -e " ${GB}[0]${NC} ${WB}Back To Menu${NC}"
echo -e "${GB}———————————————————————————————————————————————————————${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; add-vless ; exit ;;
2) clear ; trialvless ; exit ;;
3) clear ; extend-vless ; exit ;;
4) clear ; del-vless ; exit ;;
5) clear ; cek-vless ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo -e "salah tekan " ; sleep 1 ; vless ;;
esac
