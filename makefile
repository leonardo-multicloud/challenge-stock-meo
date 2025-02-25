.PHONY: install test build run stop deploy

install:
	pip install -r api_backend/requirements.txt

test:
	pytest api_backend/tests/

build:
	docker build -t leonardomulticloud/challenge-stock-meo-backend:v1.0 ./api_backend --no-cache

push:
	docker push leonardomulticloud/challenge-stock-meo-backend:v1.0

run:
	docker-compose up -d

stop:
	docker-compose down
