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

manpage:
	@echo "Generating manpage ..."
	[ -d $(OUTPUTDIR)/css ] || mkdir -p $(OUTPUTDIR)/css
	# download latest zfsnap manpage
	wget https://raw.githubusercontent.com/zfsnap/zfsnap/master/man/man8/zfsnap.8 -O zfsnap.8
	# convent to html5
	mandoc -Thtml -Ostyle=/css/manpage.css zfsnap.8 > $(OUTPUTDIR)/zfsnap_manpage.html || usr/bin/mandoc -Thtml -Ostyle=/css/manpage.css zfsnap.8 > $(OUTPUTDIR)/zfsnap_manpage.html
	# get default mandoc CSS
	wget http://mandoc.bsd.lv/cgi-bin/cvsweb/~checkout~/mandoc.css -O $(OUTPUTDIR)/css/manpage.css

.PHONY: all clean help html mandoc_check manpage static
