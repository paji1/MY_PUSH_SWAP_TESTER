# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tel-mouh <tel-mouh@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/16 06:09:02 by tel-mouh          #+#    #+#              #
#    Updated: 2022/05/16 18:21:32 by tel-mouh         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh
bold=$(tput bold)
normal=$(tput sgr0)
if [ -z $1 ] || [ -z $2 ]
then
	echo "${bold}missing of argement${normal}"
	echo "# ./tester.sh" "[size_of stack]" "[number_of_test]"
	echo "${bold} example:${normal}"
	echo "# ./tester.sh 500 100"
	exit 1
fi
make  -s -C ../ > /dev/null 2>&1
if [ $? -ne 0 ]; then
   echo MAKEFILE ERROR
   exit 1
fi
ls ../push_swap > /dev/null 2>&1
if [ $? -eq 2 ]; then
   echo push_swap not found check your make file 
   exit 1
fi


ch=""
fun()
{
	if [ $1 -eq 100 ]
	then
		if [ $2 -lt 701 ]
		then
			ch="\e[42m5 POINT\e[49m"
		elif [ $2 -lt 901 ]
		then
			ch="\e[42m4 POINT\e[49m"
		elif [ $2 -lt 1101 ]
		then
			ch="\e[42m3 POINT\e[49m"
		elif [ $2 -lt 1301 ]
		then
			ch="\e[42m2 POINT\e[49m"
		elif [ $2 -lt 1501 ]
		then
			ch="\e[42m1 POINT\e[49m"
		fi
	elif [ $1 -eq 500 ]
	then
		if [ $2 -lt 5501 ]
		then
			ch="\e[42m5 POINT\e[49m"
		elif [ $2 -lt 7001 ]
		then
			ch="\e[42m4 POINT\e[49m"
		elif [ $2 -lt 8501 ]
		then
			ch="\e[42m3 POINT\e[49m"
		elif [ $2 -lt 10001 ]
		then
			ch="\e[42m2 POINT\e[49m"
		elif [ $2 -lt 11501 ]
		then
			ch="\e[42m1 POINT\e[49m"
		fi
	elif [ $1 -eq 3 ]
	then
		if [ $2 -lt 4 ]
		then
			ch="\e[42m5 POINT\e[49m"
		else
			ch="\e[101m0 POINT\e[49m"
		fi
	elif [ $1 -eq 5 ]
	then
		if [ $2 -lt 13 ]
		then
			ch="\e[42m5 POINT\e[49m"
		else
			ch="\e[101m0 POINT\e[49m"
		fi
	else
		ch="\e[42m5 POINT\e[49m"
	fi
}
i=0
best=0
ISOK="Ok"
min=10000
rm -rf log.txt
while [ $i -lt $2 ]
do
   T=`seq $1 | sort -R | tee numbers.txt | xargs ../push_swap | wc -l`
   ARG=`tr '\n' ' ' < numbers.txt`
   SYSS=`uname -s`
	if [ $SYSS = "Linux" ]
	then
   	CHECK=`../push_swap $ARG | ./utils/checker $ARG`
	else
	CHECK=`../push_swap $ARG | ./utils/checker_Mac $ARG`
	fi
   	if [ $CHECK = "Error" ]
	then
		echo ERROR
		exit 1
	fi
   	if [ $CHECK = "KO" ]
	then
		echo $((i + 1)) "--" $ARG >> log.txt
		ISOK="KO"
	fi
   fun $1 $T
	
   if [ $CHECK = "OK" ];then
   printf "\e[36m$((i +1))\e[39m\t$T\t ${bold}$ch${normal}\t\e[92m$CHECK\e[39m\n"
   else
   ch="\e[101m0 POINT\e[49m"
   printf "\e[36m$((i +1))\e[39m\t$T\t ${bold}$ch${normal}\t\e[91m$CHECK\e[39m\n"
	fi
   if [ $T -gt $best ];
   then 
		best=$T
   fi
   if [ $T -lt $min ];
   then 
		min=$T
   fi
   rm -rf numbers.txt
   i=`expr $i + 1`
done
printf "\n${bold}\\e[93mMAX Instruction\e[39m $best${normal}\n"
printf "\e[93mAVREGE Instruction\e[39m $(((best + min) /2 ))\n"
printf "\e[93mMIN Instruction\e[39m $min\n"

fun $1 $best
if [ $ISOK = "KO" ]
then
	printf "\n      \e[101m${bold}NOT ALL INSTRUCTION WORK WITH ${normal}\e[39m\e[101mOk\e[49m\n"
	printf "\n           \e[101m${bold}CHECK THE LOG FILE${normal}\e[39m\e[101m\e[49m\n"
else
	printf "\e[93mYOU GOT\e[39m${bold} $ch${normal}\n\n"
	printf "      \e[42m${bold}ALL INSTRUCTION WORK WITH OK${normal}\e[49m\n"
fi