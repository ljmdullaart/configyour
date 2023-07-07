#!/bin/bash
#INSTALLEDFROM verlaine:/home/ljm/src/configyour
#INSTALL@ /usr/local/bin/installedfrom

sed -i "/^#INSTALLEDFROM/d" $1
sed -i "2i#INSTALLEDFROM $(hostname):$(pwd)" $1
