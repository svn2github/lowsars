parts=part0 part1 part2
usefulpages=about.html faq.html developing.html download.html gpdownload.html help.html index.html screenshot.html afdownload.html
allpages=empty.html $(usefulpages)
alluseful=$(usefulpages)
.PHONY: all
all: $(usefulpages)
	@echo Done.
$(allpages): %.html : %.html.in %.html.title $(parts)
	./GenHtml.sh $@
upload: $(alluseful) mycss.css
	echo "cd /home/groups/l/lo/lowsars/htdocs" > upload.bat
	echo "mput $?" >> upload.bat
	psftp oldherl@shell.sourceforge.net -bc -b upload.bat
	touch upload
