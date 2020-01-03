.PHONY: venv
venv:
	virtualenv -p python3 venv --no-site-packages

.PHONY: setup
setup:
	pip install -r requirements.txt
	pip install --editable .

.PHONY: docs
docs:
	mkdocs serve

.PHONY: deploy
deploy:
	mkdocs gh-deploy

.PHONY: run
run:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose down
