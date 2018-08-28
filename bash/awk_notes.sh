awk '{print}'
awk '{print $1}'
awk '{print "Korisnik: " $1 "\t\t je registrovan na sistem"}'
awk '{print NF}' # stampa koliko ima polja u liniji
awk '{print $NF}'|sort|uniq -c #poslednje polje u liniji
awk '{print NR" : \t"$0}' #broj linija
ls -l|awk '{totalsize+=$5;print totalsize}'
ls -l|awk '{totalsize+=$5}END{print totalsize}'
df|awk '{if ($3==0) print}'
df|awk '{if ($4>=90) print}'
df|awk '{if($4>=90 || $3==0)print}'
awk '{print $0, "NovaColona"}' original.file # awk add column Dodaje novu kolonu na kraj
awk '{ print $1, substr($2, 1, 4); }' original.file # Skracuje 2. Kolonu na 4 karaktera
awk NF #delete blank lines remove empty lines
awk -F “_” '{print $1}' #promena delimitera
# print sentese each word one line 
echo 'this is a sample sentence'|awk '{for (i=1;i<=NF;i++) print $i}'

