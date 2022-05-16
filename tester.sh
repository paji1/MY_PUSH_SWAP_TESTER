# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tel-mouh <tel-mouh@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/16 06:09:02 by tel-mouh          #+#    #+#              #
#    Updated: 2022/05/16 11:26:09 by tel-mouh         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh
make -s -C ../ 
ch=""
bold=$(tput bold)
normal=$(tput sgr0)
fun()
{
	if [ $1 -eq 100 ]
	then
		if [ $2 -lt 700 ]
		then
			ch="\e[42m5 POINT\e[49m"
		elif [ $2 -lt 900 ]
		then
			ch="\e[42m4 POINT\e[49m"
		elif [ $2 -lt 1100 ]
		then
			ch="\e[42m3 POINT\e[49m"
		elif [ $2 -lt 1300 ]
		then
			ch="\e[42m2 POINT\e[49m"
		elif [ $2 -lt 1500 ]
		then
			ch="\e[42m1 POINT\e[49m"
		fi
	elif [ $1 -eq 500 ]
	then
		if [ $2 -lt 5500 ]
		then
			ch="\e[42m5 POINT\e[49m"
		elif [ $2 -lt 7000 ]
		then
			ch="\e[42m4 POINT\e[49m"
		elif [ $2 -lt 8500 ]
		then
			ch="\e[42m3 POINT\e[49m"
		elif [ $2 -lt 10000 ]
		then
			ch="\e[42m2 POINT\e[49m"
		elif [ $2 -lt 11500 ]
		then
			ch="\e[42m1 POINT\e[49m"
		fi
	fi
}
i=0
best=0
ISOK="Ok"
min=10000
while [ $i -lt $2 ]
do
   T=`seq $1 | sort -R | tee numbers.txt | xargs ../push_swap | wc -l`
   ARG=`tr '\n' ' ' < numbers.txt`
   SYSS=`uname -s`
	if [ $SYSS = "Linux" ]
	then
   	CHECK=`../push_swap $ARG | ./checker $ARG`
	else
	CHECK=`../push_swap $ARG | ./checker_Mac $ARG`
	fi
   	if [ $CHECK = "KO" ]
	then
		ISOK="KO"
	fi
	
   fun $1 $T
   if [ $CHECK = "OK" ];then
   printf "\e[36m$((i +1))\e[39m\t$T\t ${bold}$ch${normal}\t\e[92m$CHECK\e[39m\n"
   else
   ch="\e[101m0 POINT\e[49m"
   printf "\e[36m$((i +1))\e[39m\t$T\t${bold}$ch${normal}\t\e[91m$CHECK\e[39m\n"
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
printf "\e[93mMAX Instruction\e[39m $best\n"
printf "\e[93mAVREGE Instruction\e[39m $(((best + min) /2 ))\n"
printf "\e[93mMIN Instruction\e[39m $min\n"

fun $1 $best
if [ $ISOK = "KO" ]
then
	printf "\n      \e[101mNOT ALL INSTRUCTION WORK WITH \e[39m\e[101mOk\e[49m\n"
else
	printf "\e[93mYOU GOT\e[39m $ch\n\n"
	printf "      \e[42m${bold}ALL INSTRUCTION WORK WITH OK${normal}\e[49m\n"
fi