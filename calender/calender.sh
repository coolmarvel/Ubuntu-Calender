#!/bin/bash
while true
do
	f_year=1900	#첫 시작년도 초기화
	s_days=0	#첫 시작년도 이후 일 수를 더해 저장할 변수
	month=(31 28 31 30 31 30 31 31 30 31 30 31)	
			#평년 기준 각 달마다 일 수를 저장한 배열변수
	#출력화면을 꾸며줄 echo 명령어 모음
	echo	""
	echo	"==================================="
	echo	"============== 달력  =============="
	echo -n "----> Input Year : "
	read C_year	#보려는 해당 연도를 입력받아 c_year에 저장
	while [ $f_year -lt $c_year ]	#f_year(첫 시작년도)가 c_year(입력한 연도)보다
	do				#작을 때까지 반복문을 실행함
		if [ `expr $f_year % 400` -eq 0 ] #f_year가 4로 나눠지고,
		then
			if [ `expr $f_year % 400` -eq 0 ]	#f_yaer가 400으로도 나워지면
			then					#윤년이므로 평년 365일에서 +1을 함
				s_days=`expr $s_days + 366`	#'366'을 s_days 변수에 더해줌
			elif [ `expr $f_year % 100` -eq 0 ]	#f_year가 100으로 나눠지면 평년이므로
			then
				s_days=`expr $s_days + 365`	#s_days변수에 '365'를 더해줌
			else					#100으로 나눠지지 않는다면
				s_days=`expr $s_days + 366`	#윤년이므로 s_days 변수에 '366'을 더해줌
			fi
		else					#4로 안나눠지면 평년이므로
			s_days=`expr $s_days + 365`	#s_days변수에 '365'를 더해줌
		fi
		f_year=`expr $f_year + 1`	#입력한 연도까지 일수를 구하기 위해
						#처음 기준(1900년)부터 +1을 함
	done

	echo ""
	echo	"==================================="
	echo	"============== 달력 ==============="
	echo	"--> 1. Input Month?"
	echo	"--> 2. Show Year?"
	echo -n "---->"
	read choice		#메뉴번호를 choice변수로 입력받음
							#입력된 연도가 윤년인지 판단
	if [ `expr $c_year % 4` -eq 0 ]			#c_year가 4로 나눠지고,
	then
		if [ `expr $c_year % 400` -eq 0 ]	#c_year가 400으로도 나눠지면
		then					#윤년이므로 month[1]은 2월이므로,
			month[1]=29			#29일 즉, 29일을 대입한다.
		elif [ `expr $c_year % 100` -eq 0 ]	#c_year가 100으로 나눠지면
		then	#윤년이 아니므로
			month[1]=28	#평년의 해당되는 28일을 대입하고,
		else	#그 외 4로 나눠지는 연도는 윤년이므로
			month[1]=29 #윤년에 해당되는 29일을 대입한다.
		fi
	else						#c_year가 4로 나눠지지 않는다면 평년이므로
		month[1]=28				#month[1]에 28일을 대입한다.
	fi					#위에 조건문으로 윤년이 판단되면 month[1],
						#즉 2월의 일수는 29일로 되어있고 평년이라면
						#28일로 값이 변해있다.

	if [ $choice -eq 1 ]		#1번 메뉴를 선택했을때
	then
		i=0		#달의 일수가 저장된 onth의 배열 인덱스로 사용할 변수 i 초기화
		echo ""
		
		echo	"==================================="
		echo	"============== 달력 ==============="
		echo -n " ----> Input Month : "
		read c_month	#보려는 달을 입력받음
		while [ $i -lt `expr $c_month - 1` ]		#예를들면 5월의 달력을 보고싶으면
		do						#4월달까지의 일수를 더해줘야하므로
			s_days=`expr $s_days + ${month[$i]}`	#i가 입력한 c_month -1한 값보다
		       i=`expr $i + 1`				#작을때까지 돌아가면서 일수를 더한다
	       							#또한 c_month -1한 이유는 배열 index는
						 		#0부터 시작하고 입력한 달은 +1이 되어
								#입력 받으므로 c_month에 -1을 해준다
		done
		echo ""
		echo "========= $c_year / $c_month ========"
		echo "Sun  Mon  Tue  Wed  Thu  Fri  Sat "

		cnt=`expr $s_days + 1`	#출력 될 일의 위치를 기억하기 위한 변수이다
					#일(0) 월(1) 화(2) 수(3) ... 토(6)로 되어있는데
					#1900년 1월 1일은 월요일부터 시작하므로 cnt값이 1인데
					#거기에 총 일수(s_days)를 더한다.
		cnt=`expr $cnt % 7`	#1+s_days를 한 변수에 일주일로 보기 위해서 %7을 해주면
					#해당 월의 첫시작 위치(나머지 값)를 cnt에 저장하게 된다
		temp=0		#임시로 사용할 변수
		while [ $temp -lt $cnt ]	#첫시작위치(cnt)에 날짜가 시작될 수 있게
		do				#temp가 cnt보다 작을때까지
			echo -n "     "		#공백을 넣어주어 해당 위치에 시작하게 하는
			temp=`expr $temp + 1`	#반복문이다
		done
		temp=1
		
		while [ $temp -le ${month[$i]} ]	#1일부터 시작하는데 해당 월의 일수보다
		do					#작거나 같을때까지 반복하여 출력한다
			if [ `expr $cnt % 7` -eq 0 ]	#cnt % 7이 0과 같으면 일주일이 모두 채워진 것
			then				#이므로, 한줄 개행한다.
				echo ""
			fi
			if [ $temp -ge 10 ]		#일수가 10보다 크거나 같게되면
			then				#자리가 2자리를 차지하므로
				echo -n " $temp"	#출력하는데에 엇나갈 수 있어서
			else				#가지런히 출력할 수 있게
				echo -n "  $temp"	#공백의 차이를 조건문으로 판단함.
			fi
			echo -n "  "
			temp=`expr $temp + 1`	#일 수 증가
			cnt=`expr $cnt + 1`	#위치값 증가(일수가 늘어날 때마다 위치도 증가하므로)
		done
		echo ""
	elif [ $choice -eq 2 ]	#2번 메뉴를 선택했을때(전체 달력 출력)
	then
		i=0		#달의 일수가 저장된 onth의 배열 인덱스로 사용할 변수 i 초기화
		cnt=`expr $s_days + 1`	#위치값(cnt)에 1+s_days를 해주어 시작할 위치를 기억한다
		while [ $i -le 11 ]	#인덱스(i)가 11보다 작거나 같을때까지 반복함
		do
			echo ""
			echo "======== $c_year / `expr $i + 1` ========="
				#해당 달은 인덱스(i)보다 1이 더 크므로 출력할 때 +1한 값을 출력하게 계산함
			echo "Sun  Mon  Tue  Wed  Thu  Fri  Sat "

			cnt=`expr $cnt % 7`	#해당 월의 첫시작 위치(나머지 값)를
						#cnt에 저장하게 된다
			temp=0			#임시로 사용할 변수 temp

			while [ $temp -lt $cnt ]#첫 시작일을 쓰기 위하여 위치값보다 작을때까지
			do			#공백을 넣는다.
				echo -n "     "
				temp=`expr $temp + 1`
			done

			temp=1
			while [ $temp -le ${month[$i]} ]	#1일부터 시작하는데 해당 월의 일수보다
			do					#작거나 같을때까지 반복하여 출력한다
				if [ `expr $cnt % 7` -eq 0 ]	#cnt % 7이 0과 같으면 일주일이 모두
				then				#채워진 것이므로, 한줄 개행한다.
					echo ""
				fi
				if [ $temp -ge 10 ]		#일수가 10보다 크게되면
				then				#2자리를 차지하기 때문에
					echo -n " $temp"	#공백을 줄임으로써
				else				#출력할 때 가지런하게 할 수 있다.
					echo -n "  $temp"
				fi
				echo -n "  "
				temp=`expr $temp + 1`	#일 수 증가
				cnt=`expr $cnt + 1`	#위치값 증가(일수가 늘어날 때마다 위치도 증가)
			done
			echo ""
			i=`expr $i + 1`	#배열에 사용할 인덱스(i) 값을 +1 증가시킨다.
		done
	fi

	echo ""
	echo	"==================================="
	echo	"============== 달력 ==============="
	echo	"--> 1. Continue?"
	echo	"--> 2. Program Exit?"
	echo -n "----> "
	read choice		#메뉴를 선택 번호를 받아 저장
	if [ $choice -eq 2 ]	#선택 번호가 2번과 같으면
	then			#무한 루프에서 나올 수 있도록
		break		#break문을 사용하여 나오게 함
	fi
done

#복붙하지 않았습니다.... 열심히 타이핑 하면서 이해하려 애썼씁니다...
