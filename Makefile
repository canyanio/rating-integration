docker_compose_files = -f docker-compose.yaml -f docker-compose.carrier.yaml -f docker-compose.kamailio.yaml -f docker-compose.tester.yaml

.PHONY: venv
venv:
	virtualenv -p python3 venv --no-site-packages

.PHONY: setup
setup:
	pip install -r requirements.txt

.PHONY: docs
docs:
	mkdocs serve

.PHONY: deploy
deploy:
	mkdocs gh-deploy

.PHONY: start
start:
	docker-compose $(docker_compose_files) up -d

.PHONY: test
test:
	docker exec rating-integration_tester_1 pytest /tests/

.PHONY: logs
logs:
	docker-compose $(docker_compose_files) ps -a
	docker-compose $(docker_compose_files) logs

.PHONY: stop
stop:
	docker-compose $(docker_compose_files) down
