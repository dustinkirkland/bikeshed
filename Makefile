PREFIX ?= /usr
VERSION = 1.5

SCRIPTS = \
	col1 \
	bch \
	bzrp \
	dman \
	pbput \
	release \
	release-build \
	wifi-status \
	$(NULL)

LINKS = \
	col2 \
	col3 \
	col4 \
	col5 \
	col6 \
	col7 \
	col8 \
	col9 \
	NF \
	pbget \
	pbputs \
	$(NULL)

TARGET_col2 = col1
TARGET_col3 = col1
TARGET_col4 = col1
TARGET_col5 = col1
TARGET_col6 = col1
TARGET_col7 = col1
TARGET_col8 = col1
TARGET_col9 = col1
TARGET_NF = col1
TARGET_pbget = pbput
TARGET_pbputs = pbput

EXTRA_DIST = \
	q \
	img/bikeshed.odp \
	img/bikeshed.png \
	img/bikeshed_14.png \
	img/bikeshed_64.png \
	img/bikeshed_192.png \
	$(NULL)

all:

clean:

install:
	install -d $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(PREFIX)/share/man/man1
	$(foreach script,$(SCRIPTS),install $(script) $(DESTDIR)$(PREFIX)/bin/$(script) &&) true
	$(foreach script,$(SCRIPTS),install $(script).1 $(DESTDIR)$(PREFIX)/share/man/man1/$(script).1 &&) true
	$(foreach link,$(LINKS),ln -s $(TARGET_$(link)) $(DESTDIR)$(PREFIX)/bin/$(link) &&) true
	$(foreach link,$(LINKS),ln -s $(TARGET_$(link)).1.gz $(DESTDIR)$(PREFIX)/share/man/man1/$(link).1.gz &&) true

dist: bikeshed-$(VERSION).tar.gz

%.tar.gz: $(SCRIPTS) $(SCRIPTS:%=%.1) $(EXTRA_DIST) Makefile
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | gzip -cn9 > $@

%.tar.bzip2:
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | bzip2 -cz9 > $@

.PHONY: all clean dist install
