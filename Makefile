
include config.mk

VERSION = 0.1.1
ETREE = etree-$(VERSION)

.PHONY: install
install: doc
	install -d $(libdir) $(docdir)/etree
	install src/etree.lua $(libdir)
	install doc/*.html doc/*.txt doc/*.css $(docdir)/etree

.PHONY: clean
clean:
	rm -rf *~ *.tar.gz
	rm -rf build
	rm -rf doc/*~
	rm -rf src/*~
	make -C doc clean

.PHONY: dist
dist: doc
	rm -rf build; mkdir build; cd build; mkdir $(ETREE)
	cp README LICENSE build/$(ETREE)
	cp config.mk Makefile build/$(ETREE)
	cd build/$(ETREE); mkdir src; mkdir doc
	cp -rf src/etree.lua build/$(ETREE)/src
	cp -rf doc/*.txt doc/*.html doc/*.css doc/*.lua build/$(ETREE)/doc
	cp -rf doc/Makefile build/$(ETREE)/doc
	cd build; tar zcvf $(ETREE).tar.gz $(ETREE)
	cp build/$(ETREE).tar.gz .

.PHONY: doc
doc:
	make -C doc
