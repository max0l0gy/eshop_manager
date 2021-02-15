# Publish Container Images to Docker Hub / Image registry with Docker
docker build -t maxmorev/eshop-manager-web:0.0.1 .
docker build -t docker.io/maxmorev/eshop-manager-web:0.0.1 .
docker push docker.io/maxmorev/eshop-manager-web:0.0.1
