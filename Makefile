BASEDIR=./
INPUTDIR=$(BASEDIR)/content
STATICDIR=$(BASEDIR)/static
OUTPUTDIR=$(BASEDIR)/output

FRAGMENTS=$(wildcard $(INPUTDIR)/*.fragment)

help:
	@echo 'Makefile for zfsnap website                                            '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make all                         generate html and convert manpage  '
	@echo '   make clean                       remove the generated files         '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make manpage                     generate html from manpage         '
	@echo '   make publish                     copy output/ to master branch      '
	@echo '                                                                       '

all: html manpage
	@echo "All ..."

clean:
	@echo "Cleaning ..."
	[ ! -d $(OUTPUTDIR) ] || find $(OUTPUTDIR) -mindepth 1 -delete

html:
	@echo "Generating html ..."
	[ -d $(OUTPUTDIR) ] || mkdir $(OUTPUTDIR)

	cp -vR $(STATICDIR)/* $(OUTPUTDIR)

	for f in $(FRAGMENTS); do \
		FILE_NAME=$${f##*/} ;\
		TITLE="$${FILE_NAME%.fragment} - zfsnap" ;\
		[ "$${FILE_NAME%.fragment}" != 'index' ] || TITLE="zfsnap" ;\
		./build_html "$$f" "$$TITLE"  > $(OUTPUTDIR)/$${FILE_NAME%.fragment}.html ;\
	done

# mandoc is required to convert the manpage to html
# groff's output is truly terrible and outright unreadable
# Unfortunately, mandoc is not available for Debian. :-/
# Thus, this is FreeBSD-specific for the time-being
mandoc_check:
	@echo "Checking for mandoc ..."
	@[ `which mandoc` ] || echo "Mandoc required! Bailing."

manpage: mandoc_check
	@echo "Generating manpage ..."
	@echo "Make sure your ../zfsnap repo is updated, to have the latest manpage."
	@echo "./zfsnap.8 is a symlink. If you're having problems, start there."
	mandoc -Txhtml -Ostyle=/css/manpage.css zfsnap.8 > $(OUTPUTDIR)/zfsnap_manpage.html
	# default mandoc CSS
	cp -v /usr/share/mdocml/style.css $(OUTPUTDIR)/css/manpage.css

publish: html
	git checkout master
	git add $(OUTPUTDIR)/*
	git mv -fkv $(OUTPUTDIR)/* ./
	git commit -m "Website update"
	git checkout site-code

.PHONY: all clean help html mandoc_check manpage publish
