#!/bin/bash
# INSTALACAO BASICA
clear
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ADMbot.sh C-SSR.sh Crear-Demo.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py Shadowsocks-R.sh Shadowsocks-libev.sh Unlock-Pass-VULTR.sh apacheon.sh blockBT.sh budp.sh dns-netflix.sh   dropbear.sh fai2ban.sh gestor.sh menu message.txt openvpn.sh paysnd.sh ports.sh shadowsocks.sh sockspy.sh speed.sh speedtest.py squid.sh squidpass.sh ssl.sh tcp.sh ultrahost usercodes utils.sh v2ray.sh"
SCPT_DIR="/etc/SCRIPT"
IVAR="/etc/http-instas"
BARRA="\033[1;36m-----------------------------------------------------\033[0m"
_hora=$(printf '%(%H:%M:%S)T') 
_fecha=$(printf '%(%D)T') 

#COLORES 
red=$(tput setaf 1)
gren=$(tput setaf 2)
yellow=$(tput setaf 3)
SCPdir="/etc/newadm" && [[ ! -d ${SCPdir} ]] && exit 1
SCPusr="${SCPdir}/ger-user" && [[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
SCPidioma="${SCPdir}/idioma"
#PROCESSADOR
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")

#SISTEMA-USO DA CPU-MEMORIA RAM
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})

_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")

# Funcoes Globais
msg () {
local colors="/etc/new-adm-color"
if [[ ! -e $colors ]]; then
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[91m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;97m' #MAG='\033[1;36m'
else
local COL=0
for number in $(cat $colors); do
case $number in
1)COLOR[$COL]='\033[1;37m';;
2)COLOR[$COL]='\e[31m';;
3)COLOR[$COL]='\e[32m';;
4)COLOR[$COL]='\e[33m';;
5)COLOR[$COL]='\e[34m';;
6)COLOR[$COL]='\e[35m';;
7)COLOR[$COL]='\033[1;36m';;
esac
let COL++
done
fi
NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${COLOR[1]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${COLOR[3]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm2)cor="${COLOR[1]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${COLOR[6]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${COLOR[2]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${COLOR[0]}${SEMCOR}" && echo -e "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${COLOR[1]}=====================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}

os_system () {
system=$(echo $(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //'))
echo $system|awk '{print $1, $2}'
}

meu_ipe () {
if [[ -e /etc/MEUIPADM ]]; then
echo "$(cat /etc/MEUIPADM)"
else
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && echo "$MEU_IP2" || echo "$MEU_IP"
echo "$MEU_IP2" > /etc/MEUIPADM
fi
}

# EXECUCION DE MENU
export -f msg
export -f selection_fun
export -f fun_trans
export -f  menu_func
export -f meu_ipe
export -f fun_ip
clear
#########VISUALIZACION DE MENU
msg -bar
echo -e "\e[97m\033[1;41m       =====>>►► 🐲 GEN VPS•MX 🐲 ◄◄<<=====       \033[1;37m"
msg -bar
msg -ne "   S.O: " && echo -ne "\033[1;37m$(os_system)"
msg -ne "       IP: " && echo -e "\033[1;37m$(meu_ipe)"
echo -e "   \033[1;31mRAM: \033[1;32m$ram1                 \033[1;31mCPU: \033[1;32m $_core"
echo -e "   \033[1;31mUSADA: \033[1;32m$ram3               \033[1;31mUSO DE CPU: \033[1;32m$_usop"
echo -e "   \033[1;31mLIBRE: \033[1;32m$ram2               \033[1;31mFECHA: \033[1;37m$_fecha"
echo -e "   \033[1;31mUSO DE RAM: \033[1;32m$_usor      \033[1;31mHORA: \033[1;37m$_hora"

[[ -e ${SCPT_DIR}/message.txt ]] && msg -bar && msg -bra " \033[1;37mKEY GENERADOR BY \033[1;32m➣➣ \033[1;96m $(cat ${SCPT_DIR}/message.txt) "
msg -bar
echo -e " \033[1;37mKEYS USADAS: \033[1;32m$(cat $IVAR)"
msg -bar

# SCPT_DIR="/etc/SCRIPT"
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
INSTA_ARQUIVOS="ADMVPS.zip"
DIR="/etc/http-shell"
LIST="lista-arq"
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

mudar_instacao () {
while [[ ${var[$value]} != 0 ]]; do
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ADMbot.sh C-SSR.sh Crear-Demo.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py Shadowsocks-R.sh Shadowsocks-libev.sh Unlock-Pass-VULTR.sh apacheon.sh blockBT.sh budp.sh dns-netflix.sh   dropbear.sh fai2ban.sh gestor.sh menu message.txt openvpn.sh paysnd.sh ports.sh shadowsocks.sh sockspy.sh speed.sh speedtest.py squid.sh squidpass.sh ssl.sh tcp.sh ultrahost usercodes utils.sh v2ray.sh"
msg -bar
echo -e "MENÚ SELECCIÓN DE INSTALACIÓN"
msg -bar
i=1
for arqx in `ls ${SCPT_DIR}`; do
[[ $arqx = @(gerar.sh|http-server.py|lista-arq) ]] && continue
[[ $(echo $BASICINST|grep -w "$arqx") ]] && echo -e "\033[1;32m[$i] \033[1;37m- [\033[1;31mX\033[1;37m] - \033[1;96m$arqx" || echo -e "\033[1;32m[$i] \033[1;37m- [ ] - \033[1;96m$arqx"
var[$i]="$arqx"
let i++
done
msg -bar
echo "[0] - FINALIZAR PROCEDIMIENTO"
msg -bar
echo -ne "Seleccione el archivo [Agregar / Eliminar]: "
read value
[[ -z ${var[$value]} ]] && return
if [[ $(echo $BASICINST|grep -w "${var[$value]}") ]]; then
rm /etc/newadm-instalacao
local BASIC=""
  for INSTS in $(echo $BASICINST); do
  [[ $INSTS = "${var[$value]}" ]] && continue
  BASIC+="$INSTS "
  done
echo $BASIC > /etc/newadm-instalacao
else
echo "$BASICINST ${var[$value]}" > /etc/newadm-instalacao
fi
done
}
fun_list () {
rm ${SCPT_DIR}/*.x.c &> /dev/null
unset KEY
KEY="$1"
#CRIA DIR
[[ ! -e ${DIR} ]] && mkdir ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh instgerador.sh http-server.py lista-arq $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e "[$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
clear
msg -bar
echo -e "\033[1;32m[x] > \033[0;31mGENERADOR DE KEYS\033[0m"
echo -e "\033[1;32m[b] > \033[0;33mINSTALACIÓN VPS-MX\033[0m"
msg -bar
read -p "Seleccione el tipo de key: " readvalue
#CRIA KEY
[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
#PASSA ARQS
[[ -z $readvalue ]] && readvalue="b"
read -p "Nombre de usuario ( comprador de la key ): " nombrevalue
[[ -z $nombrevalue ]] && nombrevalue="SIN NOMBRE"
if [[ $readvalue = @(b|B) ]]; then
#ADM BASIC
 arqslist="$BASICINST"
 for arqx in `echo "${arqslist}"`; do
 [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
 cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
 echo "$arqx" >> ${DIR}/${KEY}/${LIST}
 done
elif [[ $readvalue = @(x|X) ]]; then
# GERADOR KEYS
read -p "KEY DE ACTUALIZACIÓN?: [Y/N]: " -e -i n attGEN
[[ $(echo $nombrevalue|grep -w "FIXA") ]] && nombrevalue+=[GERADOR]
 for arqx in `ls $SCPT_DIR`; do
  [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
  cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
 echo "$arqx" >> ${DIR}/${KEY}/${LIST}
 echo "Gerador" >> ${DIR}/${KEY}/GERADOR
 done
if [[ $attGEN = @(Y|y|S|s) ]]; then
[[ -e ${DIR}/${KEY}/gerar.sh ]] && rm ${DIR}/${KEY}/gerar.sh
[[ -e ${DIR}/${KEY}/http-server.py ]] && rm ${DIR}/${KEY}/http-server.py
fi
else
 for arqx in `echo "${readvalue}"`; do
 #UNE ARQ
 [[ -e ${DIR}/${KEY}/${arq_list[$arqx]} ]] && continue #ANULA ARQUIVO CASO EXISTA
 rm ${SCPT_DIR}/*.x.c &> /dev/null
 cp ${SCPT_DIR}/${arq_list[$arqx]} ${DIR}/${KEY}/
 echo "${arq_list[$arqx]}" >> ${DIR}/${KEY}/${LIST}
 done
echo "TRUE" >> ${DIR}/${KEY}/FERRAMENTA
fi
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo "$nombrevalue" > ${DIR}/${KEY}.name
[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa
msg -bar
echo -e "Key Activa, y Esperando Instalacion!"
msg -bar
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

gerar_key () {
valuekey="$(date | md5sum | head -c10)"
valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
fun_list "$valuekey"
keyfinal=$(ofus "$IP:8888/$valuekey/$LIST")
clear
msg -bar
echo -e "\033[1;96m       >>>>>Key Generada Con Exito!<<<<<"
echo -e "$BARRA"
echo -e "\033[1;32m    $keyfinal"
echo -e "$BARRA"
echo -e "\033[1;37msudo apt update -y; apt upgrade -y; wget https://raw.githubusercontent.com/rudi9999/VPS-MX-8.0/master/instalscript.sh &> /dev/null; chmod 777 instalscript.sh* && ./instalscript.sh*"
msg -bar
read -p "Enter para Finalizar"
}
att_gen_key () {
i=0
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo "[$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
keys="$keys $arqs"
let i++
fi
done
keys=($keys)
msg -bar
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p "Seleccione qué Actualizar[t=todos]: " -e -i 0 value
done
[[ $value = 0 ]] && return
if [[ $value = @(t|T) ]]; then
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
KEYDIR="$DIR/$arqs"
rm $KEYDIR/*.x.c &> /dev/null
 if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then #Keyen Atualiza
 rm ${KEYDIR}/${LIST}
   for arqx in `ls $SCPT_DIR`; do
    cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
    echo "${arqx}" >> ${KEYDIR}/${LIST}
    rm ${SCPT_DIR}/*.x.c &> /dev/null
    rm $KEYDIR/*.x.c &> /dev/null
   done
 arqsx=$(ofus "$IP:8888/$arqs/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 fi
let i++
done
rm ${SCPT_DIR}/*.x.c &> /dev/null
msg -bar
echo -ne "\033[0m" && read -p "Enter"
return 0
fi
KEYDIR="$DIR/${keys[$value]}"
[[ -d "$KEYDIR" ]] && {
rm $KEYDIR/*.x.c &> /dev/null
rm ${KEYDIR}/${LIST}
  for arqx in `ls $SCPT_DIR`; do
  cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
  echo "${arqx}" >> ${KEYDIR}/${LIST}
  rm ${SCPT_DIR}/*.x.c &> /dev/null
  rm $KEYDIR/*.x.c &> /dev/null
  done
 arqsx=$(ofus "$IP:8888/${keys[$value]}/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 read -p "Enter"
 rm ${SCPT_DIR}/*.x.c &> /dev/null
 }
}
remover_key () {
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
clear
msg -bar
echo "[$i] Retornar"
echo -e "$BARRA"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ ! -e ${DIR}/${arqs}/used.date ]]; then
echo -e "\033[1;32m[$i] \033[1;33m$arqsx\n                   \033[1;96m($(cat ${DIR}/${arqs}.name))\033[1;32m (ACTIVA)\033[0m\n$BARRA"
else
echo -e "\033[1;31m[$i] $arqsx\n       ($(cat ${DIR}/${arqs}.name))\033[1;33m ($(cat ${DIR}/${arqs}/used.date) IP: $(cat ${DIR}/${arqs}/used))\033[0m\n$BARRA"
fi
keys="$keys $arqs"
let i++
done
keys=($keys)
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p "Elija cual eliminar: " -e -i 0 value
done
[[ -d "$DIR/${keys[$value]}" ]] && rm -rf $DIR/${keys[$value]}* || return
}
remover_key_usada () {
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
 if [[ -e ${DIR}/${arqs}/used.date ]]; then #KEY USADA
  if [[ $(ls -l -c ${DIR}/${arqs}/used.date|cut -d' ' -f7) != $(date|cut -d' ' -f3) ]]; then
  rm -rf ${DIR}/${arqs}*
  echo -e "\033[1;31m[KEY]: $arqsx \033[1;32m(ELIMINADA!)\033[0m" 
  else
  echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(AÚN VÁLIDA!)\033[0m"
  fi
 else
 echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(AÚN VÁLIDA!)\033[0m"
 fi
let i++
done
msg -bar
echo -ne "\033[0m" && read -p "Enter"
}
start_gen () {
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "http-server.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS generador /bin/http-server.sh -start
# screen -dmS generador /bin/http-server-pass.sh -start
else
killall http-server.sh
# killall http-server-pass.sh
fi
}
message_gen () {
read -p "NUEVO MENSAJE: " MSGNEW
echo "$MSGNEW" > ${SCPT_DIR}/message.txt
msg -bar
}
rmv_iplib () {
echo -e "SERVIDORES DE KEY ACTIVOS!"
rm /var/www/html/newlib && touch /var/www/html/newlib
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
var=$(cat ${DIR}/${arqs}.name)
ip=$(cat ${DIR}/${arqs}/keyfixa)
echo -ne "\033[1;31m[USUARIO]:(\033[1;32m${var%%[*}\033[1;31m) \033[1;33m[GERADOR]:\033[1;32m ($ip)\033[0m"
echo "$ip" >> /var/www/html/newlib && echo -e " \033[1;36m[ATUALIZADO]"
fi
done
echo "104.238.135.147" >> /var/www/html/newlib
msg -bar
read -p "Enter"
}
atualizar_geb () {
wget -O $HOME/instger.sh https://raw.githubusercontent.com/rudi9999/Generador_Gen_VPS-MX/master/instgerador.sh &>/dev/null
chmod +x $HOME/instger.sh
cd $HOME
./instger.sh
rm $HOME/instger.sh &>/dev/null
}
links_inst  () {
echo -e "\e[97m\033[1;41m   =====>>►► LINKS INSTALL SCRIPT VPS•MX ◄◄<<=====   \033[1;37m"
msg -bar
echo -e "\033[1;37msudo apt update -y; apt upgrade -y; wget https://raw.githubusercontent.com/rudi9999/VPS-MX-8.0/master/instalscript.sh &> /dev/null; chmod 777 instalscript.sh* && ./instalscript.sh*"
msg -bar
read -p "Enter para Finalizar"
}
meu_ip
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31moff" || PID_GEN="\033[1;32monline"
echo -e "\033[1;37mDirectorio de archivos sincronizados \033[1;31m${SCPT_DIR}\033[0m"
msg -bar
echo -e "\033[1;32m[1] \033[1;31m> \033[1;37mGENERAR 1 KEY ALEATORIA"
echo -e "\033[1;32m[2] \033[1;31m> \033[1;37mELIMINAR/MIRAR KEYS"
echo -e "\033[1;32m[3] \033[1;31m> \033[1;37mLIMPIAR REGISTRO DE KEYS USADAS"
echo -e "\033[1;32m[4] \033[1;31m> \033[1;37mALTERAR ARCHIVOS DE KEY BASICA"
echo -e "\033[1;32m[5] \033[1;31m> \033[1;37mENCENDER/APAGAR GENERADOR $PID_GEN\033[0m"
echo -e "\033[1;32m[6] \033[1;31m> \033[1;37mVER LINKS DE INSTALACION"
echo -e "\033[1;32m[7] \033[1;31m> \033[1;37mCAMBIAR CREDITOS"
echo -e "\033[1;32m[8] \033[1;31m> \033[1;37mVER REGISTRO"
echo -e "\033[1;32m[9] \033[1;31m> \033[1;37m[!] \033[1;32mACTUALIZAR GENERADOR"
msg -bar && echo -ne "$(msg -verd "[0]") $(msg -verm2 ">") "&& msg -bra "\033[1;41mSALIR DEL SCRIPT"
msg -bar
while [[ ${varread} != @([0-9]) ]]; do
read -p "Opcion: " varread
done
msg -bar
if [[ ${varread} = 0 ]]; then
exit
elif [[ ${varread} = 1 ]]; then
gerar_key
elif [[ ${varread} = 2 ]]; then
remover_key
elif [[ ${varread} = 3 ]]; then
remover_key_usada
elif [[ ${varread} = 4 ]]; then
mudar_instacao
elif [[ ${varread} = 5 ]]; then
start_gen
elif [[ ${varread} = 6 ]]; then
links_inst
elif [[ ${varread} = 7 ]]; then
message_gen
elif [[ ${varread} = 8 ]]; then
echo -ne "\033[1;36m"
cat /etc/gerar-sh-log 2>/dev/null || echo "NINGUN REGISTRO EN ESTE MOMENTO"
echo -ne "\033[0m" && read -p "Enter"
elif [[ ${varread} = 9 ]]; then
atualizar_geb
fi
/usr/bin/gerar.sh
