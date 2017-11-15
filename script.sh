#/!bin/bash

#### Debug Var ###
if [ -z $3 ];then
    debug=0
else
    debug=$3
fi
##################
#### Params #####
addrMail=$1
nameFile=$2
#################

### Variables ###
basePath="/tmp/AZ"
workPath="Work"
inPath=$workPath"/InFile"
errorPath="Error"
logsPath="Logs"
historyPath="History"
#################

#cd $inPath

list=$(ls $inPath -1)

######### CSV PARSING #################################
inp=$(cat $inPath/input.csv)

######### Declaration tableau #########################
declare -a batch 
declare -a doco
declare -a dcto
#######################################################


########### Mapping des données CSV dans des tableau ######
for input in $inp
do
    #bat=$(echo $input|cut -d ";" -f1)
    batch=( "${batch[@]}" $(echo $input|cut -d ";" -f1) )
    doco=( "${doco[@]}" $(echo $input|cut -d ";" -f2) )
    dcto=( "${dcto[@]}" $(echo $input|cut -d ";" -f3) )
    
done

if [ $debug == 1 ];then
echo "Valeurs Batch : "${batch[*]}
echo "############################"
echo "Valeurs DOCO : "${doco[*]}
echo "############################"
echo "Valeurs DCTO : "${dcto[*]}
fi
###########################################################


####################################################### 
declare final
######### Search Corresponding File ###################
lenght=${#batch[@]}
for ((i=0; i<$lenght; i++))
do
    batchValue=${bath[$i]}
    docoValue=${doco[$i]}
    dctoValue=${dcto[$i]}
    final=${batch[$i]}"_"${doco[$i]}"_"${dcto[$i]}
    if [ $debug == 1 ];then
        echo "Batch Value : "${batch[$i]}
        echo "Val Final : "$final
    fi

#######################################################

### Filename Parsing ##################################
    for name in $list
    do  
        if [ $debug == 1 ];then 
            echo "$NAME : "$name 
        fi

        for suffix in $(echo $name|cut -d "." -f2);
        do   
            if [ $debug == 1 ];then
                echo "$SUFFIX : "$suffix
            fi

            if [ "$suffix" == "txt" ];
            then
                test=$(echo $name|cut -d "." -f1)
                if [ $test == $final ];then
                    pwd
                    mv $inPath"/"$name $historyPath 
                fi
                if [ $debug == 1 ];then    
                    echo $test
                fi
            fi
        done
    done
done
##########################################################
######## Attachment Managment ############################
for i in $(ls -r $historyPath)
do
    if [ "$attachment" == "" ];then
        attachment="-a "$historyPath"/"$i
    else
        attachment=$attachment" -a "$historyPath"/"$i
    fi
done
###########################################################
####### Mail Sending ######################################

mail ""$attachment"" -v -s "Test Script" "$addrMail" < /tmp/AZ/Ressources/mail.html 
###############################################################






