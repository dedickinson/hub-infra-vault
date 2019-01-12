.PHONY: default build run stop clean

IMAGE_NAME = hub-infra-vault
CONTAINER_NAME = vault
VAULT_DATA_VOLUME = vault-data
VAULT_LOG_VOLUME = vault-log

default: build

build:
	docker volume create $(VAULT_DATA_VOLUME)
	docker volume create $(VAULT_LOG_VOLUME)
	docker build -t $(IMAGE_NAME) .

run: build
	./vault-server.sh $(CONTAINER_NAME) $(IMAGE_NAME) $(VAULT_DATA_VOLUME) $(VAULT_LOG_VOLUME)

stop:
	docker stop $(CONTAINER_NAME) || /bin/true

clean: stop
	docker rm $(CONTAINER_NAME) || /bin/true
	docker volume rm $(VAULT_DATA_VOLUME) || /bin/true
	docker volume rm $(VAULT_LOG_VOLUME) || /bin/true
