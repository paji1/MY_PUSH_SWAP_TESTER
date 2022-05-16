# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tel-mouh <tel-mouh@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/16 06:09:02 by tel-mouh          #+#    #+#              #
#    Updated: 2022/05/16 10:05:10 by tel-mouh         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh
make -s -C ../ 
ch=""
fun()
{
	if [ $1 -eq 100 ]
	then
		if [ $2 -lt 700 ]
		then
			ch="\e[42m5 POINT\e[49m"
		elif [ $2 -lt 900]
		then
			ch="\e[42m4 POINT\e[49m"
		elif [ $2 -lt 1100]
		then
			ch="\e[42m3 POINT\e[49m"
		elif [ $2 -lt 1300]
		then
			ch="\e[42m2 POINT\e[49m"
		elif [ $2 -lt 1500]
		then
			ch="\e[42m1 POINT\e[49m"
		fi
	elif [ $1 -eq 500 ]
	then
		if [ $2 -lt 5500 ]
		then
			ch="\e[42m5 POINT\e[49m"
		elif [ $2 -lt 7000]
		then
			ch="\e[42m4 POINT\e[49m"
		elif [ $2 -lt 8500]
		then
			ch="\e[42m3 POINT\e[49m"
		elif [ $2 -lt 10000]
		then
			ch="\e[42m2 POINT\e[49m"
		elif [ $2 -lt 11500]
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
   echo "\e[36m"$((i +1))"\e[39m" "\t" $T "\t" $ch "\t" "\e[92m"$CHECK
   else
   echo "\e[36m"$((i +1))"\e[39m" "\t" $T "\t" $ch "\t" "\e[91m"$CHECK
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
echo "\e[93mMAX Instruction\e[39m" $best
echo "\e[93mAVREGE Instruction\e[39m" $(((best + min) /2 ))
echo "\e[93mMIN Instruction\e[39m" $min

fun $1 $best
if [ $ISOK = "KO" ]
then
	echo "\e[101mNOT ALL INSTRUCTION WORK\e[39m" "\e[101mKO\e[49m"
else
	echo "\e[93mYOU GOT\e[39m" $ch
	echo "\e[93mALL INSTRUCTION WORK\e[39m" "\e[42mOK\e[49m"
fi