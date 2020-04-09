docker_compose_files = -f docker-compose.yaml -f docker-compose.carrier.yaml -f docker-compose.kamailio.yaml -f docker-compose.opensips.yaml -f docker-compose.tester.yaml

.PHONY: docs-venv
docs-venv:
	virtualenv -p python3 venv --no-site-packages

.PHONY: docs-setup
docs-setup:
	pip install -r requirements.txt

.PHONY: docs-serve
docs-serve:
	mkdocs serve

.PHONY: docs-deploy
docs-deploy:
	mkdocs gh-deploy

.PHONY: docker-start
docker-start:
	docker-compose $(docker_compose_files) up -d

.PHONY: docker-pull
docker-pull:
	docker-compose $(docker_compose_files) pull

.PHONY: docker-test
docker-test:
	docker exec rating-integration_tester_1 pytest /tests/

.PHONY: test-kamailio
test-kamailio:
	docker exec rating-integration_tester_1 pytest -k kamailio /tests/

.PHONY: test-opensips
test-opensips:
	docker exec rating-integration_tester_1 pytest -k opensips /tests/

.PHONY: docker-logs
docker-logs:
	docker-compose $(docker_compose_files) ps -a
	docker-compose $(docker_compose_files) logs

.PHONY: docker-stop
docker-stop:
	docker-compose $(docker_compose_files) down

.PHONY: opensips-dockerfile
opensips-dockerfile:
	docker build ./conf/opensips -t canyan/opensips:3.0.2
