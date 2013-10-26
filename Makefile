DESTDIR ?= /usr/local
BINDIR = ${DESTDIR}/bin

install:
	install -d ${BINDIR}
	install -m 755 colgrep ${BINDIR}

uninstall:
	rm -f ${BINDIR}/colgrep

test:
	@bats test/colgrep.bats

.PHONY: install uninstall test


