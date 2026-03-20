IMAGE_NAME ?= uwebarthel/alpine-image-builder
IMAGE_TAG  ?= latest

default: build

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

push: build
	docker push $(IMAGE_NAME):$(IMAGE_TAG)

shell: build
	docker run --rm -ti $(IMAGE_NAME):$(IMAGE_TAG) bash

tag:
	git tag $(TAG)
	git push origin $(TAG)
