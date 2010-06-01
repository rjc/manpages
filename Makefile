.SUFFIXES:	.html .sgml .7 .7.txt .7.html

PREFIX		 = /usr/local
INSTALL		 = install
INSTALL_PROGRAM	 = $(INSTALL) -m 0755
INSTALL_DATA	 = $(INSTALL) -m 0444
INSTALL_LIB	 = $(INSTALL) -m 0644
INSTALL_MAN	 = $(INSTALL_DATA)
SGMLS	   	 = index.sgml
HTMLS	   	 = index.html index.7.html
STATICS		 = index.css
MANS		 = index.7
TEXTS		 = index.7.txt

all:	$(HTMLS) $(MANS) $(TEXTS)

installwww: www
	$(INSTALL_DATA) $(HTMLS) $(STATICS) $(DESTDIR)$(PREFIX)/

clean:
	rm -f $(HTMLS) $(MANS) $(TEXTS)

.sgml.html:
	validate --warn $<
	cp -f $< $@

.html.7:
	lynx -dump -nolist $< | sed 's!^[ 	]*!!g' | tail -n+2 >$@

.7.7.txt:
	mandoc -Wall -fstrict $< | col -b >$@

.7.7.html:
	mandoc -Wall -Thtml -Ostyle=style.css -fstrict $< >$@
