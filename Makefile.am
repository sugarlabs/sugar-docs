all: build

.PHONY: build clean

htmldir = $(builddir)/html

build:
if BUILD_HTML
	jekyll $(srcdir) $(htmldir)
endif

clean:
	rm -rf $(htmldir)
