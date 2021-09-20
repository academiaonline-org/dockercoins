# dockercoins

```
git clone https://github.com/academiaonline/dockercoins
git checkout 2021-09

for app in hasher rng webui worker
do
  docker image build --file Dockerfile-${app} --tag academiaonline/dockercoins:2021-09-${app} /mnt/
done

docker container run --entrypoint ruby --rm --volume ${PWD}/hasher/hasher.rb:/app/hasher.rb:ro --workdir /app/ academiaonline/dockercoins:2021-09-hasher hasher.rb

docker container run --entrypoint python --rm --volume ${PWD}/rng/rng.py:/app/rng.py:ro --workdir /app/ academiaonline/dockercoins:2021-09-rng rng.py

```
