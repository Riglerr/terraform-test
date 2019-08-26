build:
	docker-compose build --force-rm --no-cache
push:
	docker-compose push

build-tool:
	@go build -v -o tool tools/tool.go

run-dev:
	docker-compose run --service-ports --rm dev

run-prod:
	docker-compose run --service-ports --rm prod