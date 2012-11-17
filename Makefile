all: build

build:
	sphinx-build -b html . build

clean:
	rm -rf build

upload:
	rsync -r --progress ./build/ \
            dnarvaez@shell.sugarlabs.org:~/public_html/sugar-docs/
