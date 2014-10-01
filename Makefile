PREFIX = /usr
VERSION = 1.29

SCRIPTS = \
	apply-patch \
	cloud-sandbox \
	bch \
	bzrp \
	dman \
	multi-push \
	name-search \
	purge-old-kernels \
	release \
	release-build \
        vigpg \
	$(NULL)

EXTRA_DIST = \
	system-search \
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
	ln -s release-build $(DESTDIR)$(PREFIX)/bin/release-test
	ln -s multi-push $(DESTDIR)$(PREFIX)/bin/multi-push-init

dist: bikeshed-$(VERSION).tar.gz

%.tar.gz: $(SCRIPTS) $(SCRIPTS:%=%.1) $(EXTRA_DIST) Makefile
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | gzip -cn9 > $@

%.tar.bzip2:
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | bzip2 -cz9 > $@

.PHONY: all clean dist install
