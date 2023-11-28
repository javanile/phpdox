
build:
	chmod +x phpdox-entrypoint.sh
	docker build -t javanile/phpdox:v2 .

push: build
	git add .
	git commit -am "publish" || true
	git push
	docker push javanile/phpdox:v2

test-help: build
	@docker run --rm -v $${PWD}:/app javanile/phpdox --help

test-sample: build
	@docker run --rm -v $${PWD}:/app -u $$(id -u) javanile/phpdox -f test/phpdox.xml

test-phploc: build
	@docker run --rm -v $${PWD}:/app -u $$(id -u) javanile/phpdox phploc --log-xml=test/phploc/phploc.xml test/fixtures
