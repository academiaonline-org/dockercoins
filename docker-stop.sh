

docker stop worker
docker network disconnect redis worker
docker network disconnect rng worker

docker stop webui
docker stop rng
docker stop hasher

#docker network rm hasher
#docker network rm redis
#docker network rm rng
