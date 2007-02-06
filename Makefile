
include config.mk

VERSION = 0.1
ETREE = etree-$(VERSION)

.PHONY: install
install:
	install -d $(libdir) $(docdir)
	install src/etree.lua $(libdir)
	make -C doc
	install doc/*.html doc/*.txt doc/*.css $(docdir)

.PHONY: clean
clean:
	rm -rf *~ *.tar.gz
	rm -rf build
	rm -rf doc/*~
	rm -rf src/*~
	make -C doc clean

.PHONY: dist
dist:
	rm -rf build; mkdir build; cd build; mkdir $(ETREE)
	cp README LICENSE build/$(ETREE)
	cp config.mk Makefile build/$(ETREE)
	cd build/$(ETREE); mkdir src; mkdir doc
	cp -rf src/etree.lua build/$(ETREE)/src
	make doc
	cp -rf doc/*.txt doc/*.html doc/*.css doc/*.lua build/$(ETREE)/doc
	cp -rf doc/Makefile build/$(ETREE)/doc
	cd build; tar zcvf $(ETREE).tar.gz $(ETREE)
	cp build/$(ETREE).tar.gz .

.PHONY: doc
doc:
	make -C doc
