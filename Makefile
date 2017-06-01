# This file is licensed under the BSD-3-Clause license.
# See the LICENSE file for more information.

BASEDIR=$(shell pwd)
CONTENTDIR=$(BASEDIR)/content
STATICDIR=$(BASEDIR)/static
OUTPUTDIR=$(BASEDIR)/output

FRAGMENTS:=$(shell find $(CONTENTDIR) -name '*.fragment')
HTMLS=$(patsubst $(CONTENTDIR)/%,%,$(FRAGMENTS:.fragment=.html))

.SUFFIXES: .html .fragment

index.html: $(CONTENTDIR)/index.fragment
	[ -d $(OUTPUTDIR) ] || mkdir $(OUTPUTDIR)
	cat $(BASEDIR)/header.html | sed s/'{{ TITLE }}'/'zfsnap'/ > $(OUTPUTDIR)/$@
	cat $< >> $(OUTPUTDIR)/$@
	cat $(BASEDIR)/footer.html >> $(OUTPUTDIR)/$@

%.html: $(CONTENTDIR)/%.fragment
	[ -d $(OUTPUTDIR) ] || mkdir $(OUTPUTDIR)
	cat $(BASEDIR)/header.html | sed s/'{{ TITLE }}'/'$* - zfsnap'/ > $(OUTPUTDIR)/$@
	cat $< >> $(OUTPUTDIR)/$@
	cat $(BASEDIR)/footer.html >> $(OUTPUTDIR)/$@

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

all: static html manpage

clean:
	@echo "Cleaning ..."
	[ ! -d $(OUTPUTDIR) ] || find $(OUTPUTDIR) -mindepth 1 -delete

html: $(HTMLS)

static:
	@echo "Copying static files ..."
	[ -d $(OUTPUTDIR) ] || mkdir $(OUTPUTDIR)
	cp -vR $(STATICDIR)/* $(OUTPUTDIR)

# mandoc is required to convert the manpage to html
# groff's output is truly terrible and outright unreadable
mandoc_check:
	@echo "Checking for mandoc ..."
	@[ `which mandoc` ] || echo "Mandoc required! Bailing."

manpage: mandoc_check
	@echo "Generating manpage ..."
	@echo "Make sure your ../zfsnap repo is updated, to have the latest manpage."
	@echo "./zfsnap.8 is a symlink. If you're having problems, start there."
	[ -d $(OUTPUTDIR)/css ] || mkdir -p $(OUTPUTDIR)

	mandoc -Txhtml -Ostyle=/css/manpage.css zfsnap.8 > $(OUTPUTDIR)/zfsnap_manpage.html
	# default mandoc CSS
	cp -v /usr/share/mdocml/style.css $(OUTPUTDIR)/css/manpage.css || cp -v /usr/share/doc/mandoc/example.style.css $(OUTPUTDIR)/css/manpage.css

publish: all
	git checkout master
	git add $(OUTPUTDIR)/*
	for FILE in `find $(OUTPUTDIR)/ -type f`; do git mv -fkv $${FILE} $${FILE#$(OUTPUTDIR)/} ; done
	git commit -m "Website update"
	git checkout site-code

.PHONY: all clean help html mandoc_check manpage publish static
