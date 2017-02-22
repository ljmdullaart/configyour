# Makefile Wed Feb 22 13:35:46 CET 2017
ALL: tag tag/htmlindex tag/in tag/pgm tag/photoswipe
clean: tag/clean.htmlindex tag/clean.in tag/clean.pgm tag/clean.photoswipe
	rm -rf tag
upload: tag/upload.htmlindex tag/upload.in tag/upload.pgm tag/upload.photoswipe
tag:
	test -d tag || mkdir tag
# htmlindex

#     #  #######  #     #  #        ###  #     #  ######   #######  #     #  
#     #     #     ##   ##  #         #   ##    #  #     #  #         #   #   
#     #     #     # # # #  #         #   # #   #  #     #  #          # #    
#######     #     #  #  #  #         #   #  #  #  #     #  #####       #     
#     #     #     #     #  #         #   #   # #  #     #  #          # #    
#     #     #     #     #  #         #   #    ##  #     #  #         #   #   
#     #     #     #     #  #######  ###  #     #  ######   #######  #     #  

tag/upload.htmlindex: |tag
	touch tag/upload.htmlindex
tag/htmlindex: |tag
	touch tag/htmlindex
tag/clean.htmlindex: |tag
	touch tag/clean.htmlindex
# in

###  #     #   ###   
 #   ##    #  #   #  
 #   # #   #      #  
 #   #  #  #   ###   
 #   #   # #      #  
 #   #    ##  #   #  
###  #     #   ###   

tag/in: |tag
	touch tag/in
tag/clean.in: |tag
	touch tag/clean.in
tag/upload.in: |tag
	touch tag/upload.in
# pgm

######    #####   #     #  
#     #  #     #  ##   ##  
#     #  #        # # # #  
######   #  ####  #  #  #  
#        #     #  #     #  
#        #     #  #     #  
#         #####   #     #  

tag/upload.pgm: |tag
	touch tag/upload.pgm
tag/pgm: tag/pgm.cron tag/pgm.bin |tag
tag/pgm.bin: /usr/local/bin/configyour /usr/local/bin/configyour.pgm /usr/local/bin/upload_all |tag
	touch tag/pgm.bin

/usr/local/bin/configyour.pgm: configyour.pgm  Makefile 
	sudo cp configyour.pgm /usr/local/bin/configyour.pgm
/usr/local/bin/configyour: configyour.sh  Makefile 
	sudo cp configyour.sh /usr/local/bin/configyour
	sudo chmod a+rx /usr/local/bin/configyour
/usr/local/bin/upload_all: upload_all.sh  Makefile 
	sudo cp upload_all.sh /usr/local/bin/upload_all
	sudo chmod a+rx /usr/local/bin/upload_all
tag/pgm.cron: Makefile |tag
	touch tag/pgm.cron
tag/clean.pgm:
	sudo rm -f /usr/local/bin/configyour /usr/local/bin/configyour.pgm /usr/local/bin/upload_all
	touch tag/clean.pgm
# photoswipe

######   #     #  #######  #######  #######   #####   #     #  ###  ######   
#     #  #     #  #     #     #     #     #  #     #  #  #  #   #   #     #  
#     #  #     #  #     #     #     #     #  #        #  #  #   #   #     #  
######   #######  #     #     #     #     #   #####   #  #  #   #   ######   
#        #     #  #     #     #     #     #        #  #  #  #   #   #        
#        #     #  #     #     #     #     #  #     #  #  #  #   #   #        
#        #     #  #######     #     #######   #####    ## ##   ###  #        

tag/upload.photoswipe: |tag
	touch tag/upload.photoswipe
tag/photoswipe: |tag
	touch tag/photoswipe
tag/clean.photoswipe:
	touch tag/clean.photoswipe
