all: build

build:
	sphinx-build -b html . build

clean:
	rm -rf build
