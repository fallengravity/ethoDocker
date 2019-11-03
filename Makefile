image: build

env:
	$(eval DOC_GIT_REF=$(shell git rev-parse --short HEAD))
	$(eval GIT_REF=$(shell echo ${DOC_GIT_REF}))

build: env
	@echo building ether1:${GIT_REF}
	docker build -t ether1:${GIT_REF} .

daemon: build
	@docker run --mount source=ether1,target=/root ether1:${GIT_REF} -p 8545:8545

node: daemon

interactive: build
	@docker run -i --mount source=ether1,target=/root ether1:${GIT_REF} attach

attach: interactive

console: interactive
