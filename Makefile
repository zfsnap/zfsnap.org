BASEDIR=./
INPUTDIR=$(BASEDIR)/content
STATICDIR=$(BASEDIR)/static
OUTPUTDIR=$(BASEDIR)/output

FRAGMENTS=$(wildcard $(INPUTDIR)/*.fragment)

help:
	@echo 'Makefile for zfsnap website                                            '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make clean                       remove the generated files         '
	@echo '                                                                       '

html:
	[ -d $(OUTPUTDIR) ] || mkdir $(OUTPUTDIR)

	cp -vR $(STATICDIR)/* $(OUTPUTDIR)

	for f in $(FRAGMENTS); do \
		FILE_NAME=$${f##*/} ;\
		TITLE="$${FILE_NAME%.fragment} - zfsnap" ;\
		[ "$${FILE_NAME%.fragment}" != 'index' ] || TITLE="zfsnap" ;\
		./build_html "$$f" "$$TITLE"  > $(OUTPUTDIR)/$${FILE_NAME%.fragment}.html ;\
	done

clean:
	[ ! -d $(OUTPUTDIR) ] || find $(OUTPUTDIR) -mindepth 1 -delete

.PHONY: html help clean
