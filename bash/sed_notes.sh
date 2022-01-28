# dodaje liniju (append) *macos gsed
sed '/seach_pattern/a line_to_append' file
# multiple patterns
sed -e 'pattern1' -e 'pattern2' file
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

 # substitute "foo" with "bar" ONLY for lines which contain "baz"
 sed '/baz/s/foo/bar/g'

 # change line c\
sed '/GRUB_TIMEOUT/c\GRUB_TIMEOUT=2' /etc/default/grub

 # append line after a\

# nalazi rec "myconfig" i 2 linije kasnije menja hostname liniju 
sed -i .bck.host "/\[myconfig/ { N; N; s/hostname.*/hostname = ${MY_HOST}/; }"  $MY_CONFIG

# MAC BOOK issue: sed: 1: "test.txt": undefined label 'est.txt'
# SOLUTION: you need to specify backup file extension 
sed -i 'bck' 's:line with spaces:replaced line with spaces:g' test.txt

###############################
# recursive find and replace
# only targeted files | "_bck" is mandarory on macOS
egrep -lr "\- some line with escaped dash" path/to/search/at/* \
    | xargs sed -i '_bck' 's:- some line with escaped dash:- replacement string:g'
find path/to/search/at -name "*_bck" -delete # removing backup files

# all files
find path/to/search/at -type f -exec \
    sed -i '_bck' 's:- some line with escaped dash:- replacement string:g' {} +
find path/to/search/at -name "*_bck" -delete
###############################

# example of special chars 
# \ is with 4 backslashes = \\\\
# " is with \" 
# \"aggregation\": \"1m\",
sed -i "s/\\\\\"aggregation\\\\\": \\\\\"1m\\\\\", //g"


