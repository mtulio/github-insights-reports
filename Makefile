
JUPLAB_IMAGE ?= mtulio/jupyter-lab:latest
PROJECT_IMAGE ?= juplab
CONTAINER ?= ghb-reports

.PHONY: build
build:
	podman build -t $(PROJECT_IMAGE) .

.PHONY: run-container
run-container:
	podman run --rm \
		-v $(PWD)/:/home/splat/project:z \
		-v $(PWD)/notebooks:/home/splat/notebooks:z \
		-v $(PWD)/secrets:/home/splat/secrets:z \
		-p 8888:8888 \
		--env-file $(PWD)/secrets/.env \
		--name $(CONTAINER) \
		-d $(PROJECT_IMAGE)
	sleep 5

.PHONY: show-notebook
show-notebook:
	podman exec $(shell podman ps --filter name=ghb-reports --format "{{.ID}}") /bin/bash -c 'jupyter notebook list'

.PHONY: run
run: run-container show-notebook 

.PHONY: clean
clean:
	podman rm -f $(shell podman ps --filter name=ghb-reports --format "{{.ID}}")
