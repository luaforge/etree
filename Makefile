
include config.mk

VERSION = 0.1
ETREE = etree-$(VERSION)
.PHONY: install
install:
	install -d $(libdir) $(docdir)
	install src/etree.lua $(libdir)
	install doc/*.html doc/*.txt $(docdir)

.PHONY: clean
clean:
	rm -rf *~ *.tar.gz
	rm -rf build
	rm -rf doc/*~
	rm -rf src/*~

.PHONY: dist
dist:
	rm -rf build; mkdir build; cd build; mkdir $(ETREE)
	cp README LICENSE build/$(ETREE)
	cp config.mk Makefile build/$(ETREE)
	cd build/$(ETREE); mkdir src; mkdir doc
	cp -rf src/etree.lua build/$(ETREE)/src
	cp -rf doc/*.txt doc/*.html build/$(ETREE)/doc
	cd build; tar zcvf $(ETREE).tar.gz $(ETREE)
	cp build/$(ETREE).tar.gz .
