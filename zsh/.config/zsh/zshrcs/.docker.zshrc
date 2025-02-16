# Docker aliases
alias dps='docker ps'
alias log='docker logs --timestamps'
alias pruneall='docker container prune; docker image prune; docker volume prune; docker network prune; docker system prune'
alias dnames="docker ps --format "{{.Names}}""

nukedocker() {
    echo "Stopping all running containers..."
    docker stop $(docker ps -q)

    echo "Removing all containers..."
    docker rm $(docker ps -a -q)

    echo "Removing all images..."
    docker rmi $(docker images -q)

    echo "Removing all volumes..."
    docker volume rm $(docker volume ls -q)

    echo "Removing all networks..."
    docker network rm $(docker network ls -q)

    echo "Pruning Docker system (containers, images, volumes, networks)..."
    docker system prune -a --volumes -f

    echo "Docker cleanup complete!"
}
