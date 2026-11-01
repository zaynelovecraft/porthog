PREFIX ?= $(HOME)/.local

install:
	mkdir -p $(PREFIX)/bin
	install -m 0755 bin/porthog $(PREFIX)/bin/porthog

uninstall:
	rm -f $(PREFIX)/bin/porthog
