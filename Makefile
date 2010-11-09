PREFIX ?= /usr
VERSION = 1.5

SCRIPTS = \
	1 \
	bch \
	bzrp \
	dman \
	pbput \
	release \
	release-build \
	wifi-status \
	$(NULL)

LINKS = \
	2 \
	3 \
	4 \
	5 \
	6 \
	7 \
	8 \
	9 \
	NF \
	pbget \
	pbputs \
	$(NULL)

TARGET_2 = 1
TARGET_3 = 1
TARGET_4 = 1
TARGET_5 = 1
TARGET_6 = 1
TARGET_7 = 1
TARGET_8 = 1
TARGET_9 = 1
TARGET_NF = 1
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
	$(foreach link,$(LINKS),ln -s $(TARGET_$(link)).1 $(DESTDIR)$(PREFIX)/share/man/man1/$(link).1 &&) true

dist: bikeshed-$(VERSION).tar.gz

%.tar.gz: $(SCRIPTS) $(SCRIPTS:%=%.1) $(EXTRA_DIST) Makefile
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | gzip -cn9 > $@

%.tar.bzip2:
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | bzip2 -cz9 > $@

.PHONY: all clean dist install
