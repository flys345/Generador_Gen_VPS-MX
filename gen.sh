#!/bin/bash
clear
cd $HOME
SCPT_DIR="/etc/SCRIPT"
SCPdir="/etc/newadm"
SCPinstal="$HOME/install"
SCPidioma="${SCPdir}/idioma"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPinst="/etc/ger-inst"
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
service apache2 restart > /dev/null 2>&1
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
mkdir -p /etc/B-ADMuser &>/dev/null
rm -rf /etc/localtime &>/dev/null
ln -s /usr/share/zoneinfo/America/Mexico_City /etc/localtime &>/dev/null
rm $(pwd)/$0 &> /dev/null
### COLORES Y BARRA 
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${VERMELHO}" && echo -ne "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${VERMELHO}======================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}

fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}  
function_verify () {
  permited=$(curl -sSL "https://raw.githubusercontent.com/rudi9999/Generador_Gen_VPS-MX/master/Control-IP")
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  echo -e "\n\n\n\033[1;95m======================================================\n ¡ESTA KEY NO CONCUERDA CON EL INSTALADOR!,CONATACTE A @Rufu99\n======================================================\n"
  [[ -d /etc/newadm ]] && rm -rf /etc/newadm
  exit 1
  } || {
  ### INTALAR VERCION DE SCRIPT
  v1=$(curl -sSL "https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/Vercion")
  echo "$v1" > /etc/versin_script
  }
}
funcao_idioma () {
msg -bar2
figlet "    -VPS MX-" | lolcat 
echo -e "     ESTE SCRIPT ESTA OPTIMIZADO A IDIOMA ESPAÑOL"
msg -bar2
pv="$(echo es)"
[[ ${#id} -gt 2 ]] && id="es" || id="$pv"
byinst="true"
}

ofus () {
unset server
server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="%";;
"%")txt[$i]="4";;
"-")txt[$i]="K";;
"K")txt[$i]="-";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
verificar_arq () {
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
case $1 in
"menu"|"message.txt")ARQ="${SCPT_DIR}/";; #Menu
"usercodes")ARQ="${SCPT_DIR}/";; #Panel SSRR
"C-SSR.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"openssh.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"squid.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"dropbear.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"openvpn.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"ssl.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"shadowsocks.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"Shadowsocks-libev.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"Shadowsocks-R.sh")ARQ="${SCPT_DIR}/";; #Instalacao 
"v2ray.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"budp.sh")ARQ="${SCPT_DIR}/";; #Instalacao
"sockspy.sh"|"PDirect.py"|"PPub.py"|"PPriv.py"|"POpen.py"|"PGet.py")ARQ="${SCPT_DIR}/";; #Instalacao
*)ARQ="${SCPT_DIR}/";; #Ferramentas
esac
mv -f ${SCPinstal}/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

fun_ip
wget -O /usr/bin/trans https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/trans &> /dev/null
wget -O /bin/Desbloqueo.sh https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/Desbloqueo.sh &> /dev/null
chmod +x /bin/Desbloqueo.sh
wget -O /bin/monitor.sh https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/Monitor-Service/monitor.sh &> /dev/null
chmod +x /bin/monitor.sh
wget -O /var/www/html/estilos.css https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/Monitor-Service/estilos.css &> /dev/null
msg -bar2
msg -bar2
msg -ama "     [ VPS - MX - SCRIPT \033[1;97m ❌ MOD By @Kalix1 ❌\033[1;33m ]"
msg -ama "  \033[1;96m      🔰Usar Ubuntu 18 a 64 De Preferencia🔰 "
msg -bar2
[[ $1 = "" ]] && funcao_idioma || {
[[ ${#1} -gt 2 ]] && funcao_idioma || id="$1"
 }
error_fun () {
msg -bar2 && msg -verm "ERROR de enlace VPS<-->GENERADOR" && msg -bar2
[[ -d ${SCPT_DIR} ]] && rm -rf ${SCPT_DIR}
exit 1
}
invalid_key () {
msg -bar2 && msg -verm "#¡Key Invalida#! " && msg -bar2
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
exit 1
}
while [[ ! $Key ]]; do
msg -bar2 && msg -ne "# DIGITE LA KEY #: " && read Key
tput cuu1 && tput dl1
done
msg -ne "# Verificando Key # : "
cd $HOME
wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -e "\033[1;32m Key Completa" || {
   echo -e "\033[1;91m Key Incompleta"
   invalid_key
   exit
   }
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
sleep 1s
function_verify
updatedb
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
   msg -bar2
   msg -verd "$(source trans -b es:${id} " INSTALANDO"|sed -e 's/[^a-z -]//ig'): \033[1;31m[VPS-MX #MOD by @Kalix1]"
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   pontos="."
   stopping="$(source trans -b es:${id} "Verificando Actualizaciones"|sed -e 's/[^a-z -]//ig')"
   for arqx in $(cat $HOME/lista-arq); do
   msg -verm "${stopping}${pontos}"
   wget --no-check-certificate -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}" || error_fun
   tput cuu1 && tput dl1
   pontos+="."
   done
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://raw.githubusercontent.com/rudi9999/Generador_Gen_VPS-MX/master/Install/trans &> /dev/null
[[ -e /bin/http-server.py ]] && mv -f /bin/http-server.py /bin/http-server.sh && chmod +x /bin/http-server.sh
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
cp $HOME/lista-arq /etc/SCRIPT
cp /bin/http-server.sh /etc/SCRIPT
mv /etc/SCRIPT/http-server.sh /etc/SCRIPT/http-server.py
wget https://raw.githubusercontent.com/rudi9999/Generador_Gen_VPS-MX/master/gerador/gerar.sh &>/dev/null
mv gerar.sh /usr/bin/
chmod +x /usr/bin/gerar.sh
cd /etc/SCRIPT
rm -rf FERRAMENTA KEY KEY! INVALIDA!
rm $HOME/lista-arq
sed -i -e 's/\r$//' /usr/bin/gerar.sh
echo -e "$BARRA"
echo "/usr/bin/gerar.sh" > /usr/bin/gerar && chmod +x /usr/bin/gerar
echo -e "\033[1;33m Perfecto, utilize el comando \033[1;31mgerar.sh o gerar \033[1;33mpara administrar sus keys y
 actualizar la base del servidor"
echo -e "$BARRA"
else
invalid_key
fi
rm -rf instalscript.sh
