parts=part0 part1 part2
usefulpages=about.html faq.html developing.html download.html help.html index.html screenshot.html
allpages=empty.html $(usefulpages)
.PHONY: all
all: $(usefulpages)
	@echo Done.
$(allpages): %.html : %.html.in %.html.title $(parts)
	./GenHtml.sh $@
