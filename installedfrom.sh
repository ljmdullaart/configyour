#!/bin/bash
#INSTALL@ /usr/local/bin/installedfrom
#INSTALLEDFROM verlaine:/home/ljm/src/configyour

sed -i "/^#INSTALLEDFROM/d" $1
sed -i "/^#INSTALL@/a#INSTALLEDFROM $(hostname):$(pwd)" $1
