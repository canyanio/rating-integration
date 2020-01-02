.PHONY: venv
venv:
	virtualenv -p python3 venv --no-site-packages

.PHONY: setup
setup:
	pip install -r requirements.txt
	pip install --editable .

.PHONY: run
run:
	mkdocs serve

.PHONY: deploy
deploy:
	mkdocs gh-deploy