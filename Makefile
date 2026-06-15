.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

CONTAINER=py

bash:
	@docker compose exec -it $(CONTAINER) bash

down:
	@docker compose down $(CONTAINER)

html:
	@docker compose exec $(CONTAINER) make html

init:
	@docker compose down $(CONTAINER) -v \
    && docker compose up -d --build $(CONTAINER) \
    && docker compose exec -it $(CONTAINER) pelican-quickstart

restart:
	@make down && make up

serve:
	@docker compose exec -d $(CONTAINER) make serve-global

up:
	@docker compose up -d $(CONTAINER)
