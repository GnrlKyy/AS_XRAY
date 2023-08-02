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
NUMBER_OF_CLIENTS=$(grep -c -E "^#&@ " "/usr/local/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e "               ${WB}Extend All Xray Account${NC}              "
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e "  ${WB}You have no existing clients!${NC}"
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
vmess
fi
clear
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e "               ${WB}Extend All Xray Account${NC}              "
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e " ${WB}User  Expired${NC}  "
echo -e "${GB}————————————————————————————————————————————————————${NC}"
grep -E "^#&@ " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
echo -e "${WB}tap enter to go back${NC}"
echo -e "${GB}————————————————————————————————————————————————————${NC}"
read -rp "Input Username : " user
if [ -z $user ]; then
vmess
else
read -p "Expired (days): " masaaktif
exp=$(grep -wE "^#&@ $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/#&@ $user/c\#&@ $user $exp4" /usr/local/etc/xray/config.json
systemctl restart xray
clear
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e "          ${WB}All Xray Account Success Extended${NC}         "
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e " ${WB}Client Name :${NC} $user"
echo -e " ${WB}Expired On  :${NC} $exp4"
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
clear
vmess
fi
