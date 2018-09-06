# menja sve dvotacke u razmake, s - substitute, g - global
sed -e 's/:/ /g'
# menja sve dvotacke u razmake, i taylor sa rema_kralj
sed -e 's/taylor/rema_kralj/g;s/:/ /g'
# brise zarez!!! :
sed 's/,/ /'
# brise trecu (3.) liniju
sed '3d'
# brise od 2 linije do 8 linije remove lines 
sed '2,8d'
# brise od paterna “start” do paterna “kraj”
sed '/start/,/kraj/d'
# brise prazne linije
sed '/^$/d'
# brise pocetne balkove remove begining blanks in the line
sed -e 's/^[ \t]*//'
# brise patern “sis” i sve prazne linije
sed '/sis/d;/^$/d' temp.txt2
# Dodaje prefix prefix_text na pocetku svake linije
sed 's/^/prefix_text/'
# selektuje samo prvi karakter 
sed 's/\(^.\).*/\1/'
# dodaje liniju posle N-te linije 
sed 'N a <LINE-TO-BE-ADDED>' FILE.txt

sed -i 's/\(IPE1.*\)5/\16/' test_file
#LC04    MIAIBYA06    IPE1EUR1YA06_BASE_1    UNIX_INDUS_LAN    6
#LC04    MIAIBYA06    IPE1EUR2YA06_APP_1    UNIX_INDUS_LAN    6
#LC04    MIAIBYA06    IPE1EUR3YA06_APP_1    UNIX_INDUS_LAN    6

#\( \) - regular expression, poziva se sa \1

sed -i 's/\(ICT2.*\)6/\15/;s/\(RPGR.*\)2/\13/;s/\(RSQT.*\)2/\13/;s/\(RSVN.*\)2/\11/;s/\(RTAO.*\)2/\13/;s/\(RWRR.*\)2/\13/;s/\(RREA.*\)2/\11/;s/\(IREA.*\)6/\15/;s/\(RCNX.*\)2/\11/;s/\(IPE1.*\)6/\15/;s/\(RPE1.*\)2/\11/;s/\(IPEE.*\)6/\15/;s/\(RPEE.*\)2/\11/;s/\(IPE8.*\)6/\15/;s/\(RPE8.*\)2/\11/;s/\(RGDM.*\)2/\11/;s/\(IBBB.*\)6/\15/' test_file

# Skracuje drugu kolunu na 8 karaktera!
sed 's/\(.*\t.\{8\}\).*/\1/' test_file

# Remove CTRL+M from the end of each line in the file ***kucati na tastaturi:  ^M=CTRL+V+M
sed -e "s/^M//" filename > newfilename
# brise sve “nema” reci i sve prazne linije
sed '/nema/d;/^$/d' in.txt > out.txt

# Brise sve linije koje sadrze 320 GB 298 GiB
sed -i '/320 GB/298 GiB/d' /var/log/messages*


