#!/bin/bash
#INSTALL@ /usr/local/bin/configyour.feature
if [ -x /usr/local/bin/my_banner ] ; then
    banner=/usr/local/bin/my_banner

else
    banner=banner
fi



echo "Configyour.feature starting" >> configyour.log
$banner feature >> Makefile

not_applicable (){
	echo 'tag/feature: |tag' >> Makefile
	echo '	touch tag/feature' >> Makefile
	echo 'tag/clean.feature: |tag' >> Makefile
	echo '	touch tag/clean.feature' >> Makefile
	echo 'Not applicable' >> configyour.log

}

# Test if applicatble; if not call `not_applicable' 

not_applicable
echo "Configyour.feature finnished" >> configyour.log
