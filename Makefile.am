all: build

.PHONY: build clean

htmldir = $(builddir)/html

build:
	sphinx-build -b html $(srcdir) $(htmldir)

clean:
	rm -rf $(htmldir)
