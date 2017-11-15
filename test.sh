#!/bin/bash
base="History/"
attachment=""
for i in $(ls -r History)
do
    if [ "$attachment" == "" ];then
        attachment="-a "$base$i
    else
        attachment=$attachment" -a "$base$i
    fi
done
echo $attachment
mail ""$attachment"" -v -s "Test Script" adrien.besson@gfi.fr < /tmp/AZ/Ressources/mail.html
