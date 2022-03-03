docker stop worker
docker stop webui
docker stop rng
docker stop hasher

docker network rm hasher
docker network rm redis
docker network rm rng
