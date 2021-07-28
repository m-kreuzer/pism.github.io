.PHONY: all build update serve check-links check-external-links install

all: check-links

img/pism_publications.png: publications/plot_references.py publications/applications.bib
	python3 $^ $@

update: img/pism_publications.png
	${MAKE} -C publications/
	${MAKE} -C usersmap/

build: update
	bundle exec jekyll build

serve:
	bundle exec jekyll serve

install:
	bundle install --path=vendor

check-links: build
	bundle exec htmlproofer \
	       --empty-alt-ignore \
	       --disable-external \
	       --typhoeus-config '{ "ssl_verifypeer": false }' \
	       --root-dir _site \
	       _site

check-external-links: build
	bundle exec htmlproofer \
	       --empty-alt-ignore \
	       --typhoeus-config '{ "ssl_verifypeer": false }' \
	       --root-dir _site \
	       _site
