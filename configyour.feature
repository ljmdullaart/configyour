#!/bin/bash
#INSTALL@ /usr/local/bin/configyour.feature
if [ -x /usr/local/bin/my_banner ] ; then
    banner=/usr/local/bin/my_banner
else
    banner=banner
fi


$banner feature >> Makefile

echo 'tag/feature: |tag' >> Makefile
echo '	touch tag/feature' >> Makefile

echo 'tag/clean.feature: |tag' >> Makefile
echo '	touch tag/clean.feature' >> Makefile

