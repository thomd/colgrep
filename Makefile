DESTDIR ?= /usr/local
BINDIR = ${DESTDIR}/bin

install:
	install -d ${BINDIR}
	install -m 755 bin/files ${BINDIR}

uninstall:
	rm -f ${BINDIR}/files

test:
	@bats test/files.bats

.PHONY: install uninstall test


