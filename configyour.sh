#!/bin/bash
#INSTALL@ /usr/local/bin/configyour
#INSTALLEDFROM verlaine:/home/ljm/src/configyour


NOW=$(date)
LOG=configyour.log
date > $LOG

CONFIGURES=/tmp/configyour.$$
BIN=/usr/local/bin
if [ "$1" = "-l" ] ; then
	BIN=.
	echo "Bin -l flag; using . as bin directoy" >>$LOG
fi
if [ -x /usr/local/bin/my_banner ] ; then
    banner=/usr/local/bin/my_banner
else
    banner=banner
fi



ls $BIN/configyour.* | sed 's/.*onfigyour.//' | grep -v sh > $CONFIGURES 2>/dev/null

$banner configyour

echo "Doing $CONFIGURES"  >>$LOG
cat $CONFIGURES >>$LOG

if [ "$1" = "-h" ] ; then
cat <<EOF

configyour creates a Makefile that seems most appropriate for this directory.
 - If a local "configure" script is present, that is pobably the best way
 - Otherwise, all configyour.feature scripts in $BIN are used to generate
   a Makefile.

If the sub-configyour are used, the following standard targets should
be available in the makefile:
- ALL
- clean

Current sub-configures are:
EOF
cat $CONFIGURES
exit 0
fi


echo "BIN=$BIN" >>$LOG

# Header and top-rules
echo "# Makefile $NOW" > Makefile
if [ -f Makefile.top ] ; then
	cat Makefile.top  >> Makefile
fi

# All-target
echo -n 'ALL: tag' >> Makefile
cat "$CONFIGURES" | while read -r type ; do
	echo -n " tag/$type" >> Makefile
done
echo "" >>Makefile

# Clean-target
echo -n 'clean:' >> Makefile
cat "$CONFIGURES" | while read -r type ; do
	echo -n " tag/clean.$type" >> Makefile
done
echo "" >>Makefile
echo "	rm -rf tag" >>Makefile

#upload-target
echo -n 'upload:' >> Makefile
cat "$CONFIGURES" | while read -r  type ; do
	echo -n " tag/upload.$type" >> Makefile
done
echo "" >>Makefile

# tag directory
echo "tag:">>Makefile
echo "	test -d tag || mkdir tag" >> Makefile

cat "$CONFIGURES" | while read -r type ; do
	ls -l "$BIN/configyour.$type" >>"$LOG"
done

for type in $(cat $CONFIGURES | paste -sd' ') ; do
	echo "# $type" >> Makefile
	$banner "$type"
	echo '************************************************************************' >>$LOG
	bash "$BIN/configyour.$type"
done


if [ -f Makefile.part ] ; then
	cat Makefile.part  >> Makefile
fi
			
#cat Makefile
rm -f $CONFIGURES
