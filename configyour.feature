#!/bin/bash
#INSTALL@ /usr/local/bin/configyour.feature
banner feature >> Makefile

echo 'tag/feature: |tag' >> Makefile
echo '	touch tag/feature' >> Makefile

echo 'tag/clean.feature: |tag' >> Makefile
echo '	touch tag/clean.feature' >> Makefile

