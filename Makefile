all: build

.PHONY: build clean

build:
	sphinx-build -b html . build

clean:
	rm -rf build
