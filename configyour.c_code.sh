#!/bin/bash
#INSTALL@ /usr/local/bin/configyour.c_code
#INSTALLEDFROM verlaine:/home/ljm/src/configyour
DEBUG=1
LOG=configyour.log
echo "$0 starting" >> $LOG
tell(){
        if [ $DEBUG -gt 0 ] ; then
                echo "  $*" >> $LOG
        fi
}

if [ -x /usr/local/bin/my_banner ] ; then
    banner=/usr/local/bin/my_banner
else
    banner=banner
fi


echo "Configyour.c_code starting" >> configyour.log
$banner c_code >> Makefile

not_applicable (){
	echo 'tag/c_code: |tag' >> Makefile
	echo '	touch tag/c_code' >> Makefile
	echo 'tag/clean.c_code: |tag' >> Makefile
	echo '	touch tag/clean.c_code' >> Makefile
	echo 'Not applicable' >> configyour.log

}

# Test if applicatble; if not call `not_applicable' 
if ls ./*.c &>/dev/null ; then
	all_c="*.c"
	echo "Found $all_c" >>$LOG
else
	not_applicable
	exit 0
fi

ctags=''
installs=''

for cfile in *.c ; do
	cstem=${cfile%.c}
	deps=''
	if grep "^#INSTALL_C@ " "$cfile" &>/dev/null ; then
		instalwhere=$(sed -n 's/^#INSTALL_C@  *//p' "$cfile")
		installs="$installs $instalwhere"
		if  grep "^#DEP " "$cfile" &>/dev/null ; then
			deps=$(sed -n 's/^#DEP //p' "$cfile" | paste -s)
		fi
		if  grep "^#MAKE " "$cfile" &>/dev/null ; then
			echo "tag/c_$cstem: $cfile $deps" >> Makefile
			ctags="$ctags tag/c_$cstem"
			sed -n 's/^#MAKE /	/p' >> Makefile
		elif grep -qE '^[^#]*\bmain\s*\(' "$cfile" ; then
			echo "tag/c_$cstem: $cstem" >> Makefile
			echo "	sudo cp $cstem $instalwhere" >> Makefile
			echo "$cstem: $cfile $deps" >> Makefile
			ctags="$ctags tag/c_$cstem"
		else
			echo "$cstem.o: $cfile $deps" >> Makefile
		fi
	else
		echo "$cstem.o: $cfile $deps" >> Makefile
	fi
		
done	

echo "tag/c_code: $ctags |tag" >> Makefile
echo '	touch tag/c_code' >> Makefile
echo 'tag/clean.c_code: |tag' >> Makefile
echo "	rm -f $installs" >> Makefile
echo '	touch tag/clean.c_code' >> Makefile

echo "Configyour.c_code finnished" >> configyour.log
