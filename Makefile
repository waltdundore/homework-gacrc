.PHONY: clean install

all: install

install:
	vagrant up --no-destroy-on-error

debug:
	vagrant up --debug --no-destroy-on-error

clean:
	vagrant destroy -f && rm -rf .vagrant