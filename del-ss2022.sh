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
NUMBER_OF_CLIENTS=$(grep -c -E "^#% " "/usr/local/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e "          ${WB}Delete Shadowsocks 2022 Account${NC}           "
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e "  ${WB}You have no existing clients!${NC}"
echo -e "${GB}————————————————————————————————————————————————————${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
shadowsocks2022
fi
clear
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e "          ${WB}Delete Shadowsocks 2022 Account${NC}           "
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e " ${WB}User  Expired${NC}  "
echo -e "${GB}————————————————————————————————————————————————————${NC}"
grep -E "^#% " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
echo -e "${WB}tap enter to go back${NC}"
echo -e "${GB}————————————————————————————————————————————————————${NC}"
read -rp "Input Username : " user
if [ -z $user ]; then
shadowsocks2022
else
exp=$(grep -wE "^#% $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#% $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
rm -rf /var/www/html/shadowsocks2022/shadowsocks2022-$user.txt
rm -rf /user/log-ss2022-$user.txt
systemctl restart xray
clear
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e "      ${WB}Shadowsocks 2022 Account Success${NC} Deleted${NC}      "
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo -e " ${WB}Client Name :${NC} $user"
echo -e " ${WB}Expired On  :${NC} $exp"
echo -e "${GB}————————————————————————————————————————————————————${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
clear
shadowsocks2022
fi