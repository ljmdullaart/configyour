#!/bin/bash
#INSTALL@ /usr/local/bin/configyour

NOW=`date`
CONFIGURES=/tmp/configyour.$$
BIN=/usr/local/bin
if [ "$1" = "-l" ] ; then
	BIN=.
fi

ls $BIN/configyour.* | sed 's/.*onfigyour.//' | grep -v sh > $CONFIGURES 2>/dev/null

banner configyour

echo "Doing $CONFIGURES"
cat $CONFIGURES

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


if [ -f configure ] ; then
	echo "# Local configure file found executing that"
	./configure
	exit 0
fi



echo "BIN=$BIN"

# Header and top-rules
echo "# Makefile $NOW" > Makefile
if [ -f Makefile.top ] ; then
	cat Makefile.top  >> Makefile
fi

# All-target
echo -n 'ALL: tag' >> Makefile
cat $CONFIGURES | while read type ; do
	echo -n " tag/$type" >> Makefile
done
echo "" >>Makefile

# Clean-target
echo -n 'clean:' >> Makefile
cat $CONFIGURES | while read type ; do
	echo -n " tag/clean.$type" >> Makefile
done
echo "" >>Makefile
echo "	rm -rf tag" >>Makefile

#upload-target
echo -n 'upload:' >> Makefile
cat $CONFIGURES | while read type ; do
	echo -n " tag/upload.$type" >> Makefile
done
echo "" >>Makefile

# tag directory
echo "tag:">>Makefile
echo "	test -d tag || mkdir tag" >> Makefile

cat $CONFIGURES | while read type ; do
	ls -l $BIN/configyour.$type
done

for type in `cat $CONFIGURES | paste -sd' '` ; do
	echo "# $type" >> Makefile
	banner $type
	bash $BIN/configyour.$type
done


if [ -f Makefile.part ] ; then
	cat Makefile.part  >> Makefile
fi
			
#cat Makefile

