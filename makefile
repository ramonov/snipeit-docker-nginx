include .env

# Remove project Docker container, image, network, volume
clean:
	docker rm ${CONTAINER_NAME_PREFIX}app
	docker rm ${CONTAINER_NAME_PREFIX}db
	docker rm ${CONTAINER_NAME_PREFIX}web
	docker rm ${CONTAINER_NAME_PREFIX}redis
	docker rmi ${IMAGE_NAME}
	docker network rm ${NETWORK}

# Rebuild Docker image and container with Docker compose
dev-rebuild:
	docker-compose -f docker-compose.yml up --detach --build

# Start Docker container with Docker compose
dev-start:
	docker-compose -f docker-compose.yml up --detach

# Build Docker image
image:
	docker build -f build/Dockerfile -t ${IMAGE_NAME} code

# Publish Docker image to Docker Hub
publish:
	docker push ${IMAGE_NAME}:latest


# Access Docker container terminal.
ssh:
	docker exec -t -i ${CONTAINER_NAME_PREFIX}app bash

# Stop Docker container
stop:
	docker-compose down
