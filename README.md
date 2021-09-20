# dockercoins

```
github_username=patrabas1
github_repo=dockercoins
github_branch=2021-09

git clone https://github.com/${github_username}/${github_repo}
cd ${github_repo}/
git checkout ${github_branch}

for app in hasher rng webui worker
do
  docker image build --file Dockerfile-${app} --tag ${github_username}/${github_repo}:${github_branch}-${app} /mnt/
done

docker container run --entrypoint ruby --rm --volume ${PWD}/hasher/hasher.rb:/app/hasher.rb:ro --workdir /app/ ${github_username}/${github_repo}:${github_branch}-hasher hasher.rb

docker container run --entrypoint python --rm --volume ${PWD}/rng/rng.py:/app/rng.py:ro --workdir /app/ ${github_username}/${github_repo}:${github_branch}-rng rng.py

docker container run --entrypoint node --rm --volume ${PWD}/webui/webui.js:/app/webui.js:ro --volume ${PWD}/webui/files/:/app/files/:ro --workdir /app/ ${github_username}/${github_repo}:${github_branch}-webui webui.js

docker container run --entrypoint python --rm --volume ${PWD}/worker/worker.py:/app/worker.py:ro --workdir /app/ ${github_username}/${github_repo}:${github_branch}-worker worker.py
```

```
for network in hasher redis rng
do
  docker network create ${network}
done

docker container run --detach --entrypoint ruby --name hasher --network hasher --restart always --volume ${PWD}/hasher/hasher.rb:/app/hasher.rb:ro --workdir /app/ ${github_username}/${github_repo}:${github_branch}-hasher hasher.rb

docker container run --detach --entrypoint docker-entrypoint.sh --name redis --network redis --restart always --volume redis:/data/:rw --workdir /data/ library/redis:alpine redis-server

docker container run --detach --entrypoint python --name rng --network rng --restart always --volume ${PWD}/rng/rng.py:/app/rng.py:ro --workdir /app/ ${github_username}/${github_repo}:${github_branch}-rng rng.py

docker container run --detach --entrypoint python --name worker --network redis --restart always --volume ${PWD}/worker/worker.py:/app/worker.py:ro --workdir /app/ ${github_username}/${github_repo}:${github_branch}-worker worker.py

docker network connect hasher worker
docker network connect rng worker

docker container run --detach --entrypoint node --name webui --network redis --publish 8080:8080 --restart always --volume ${PWD}/webui/webui.js:/app/webui.js:ro --volume ${PWD}/webui/files/:/app/files/:ro --workdir /app/ ${github_username}/${github_repo}:${github_branch}-webui webui.js

```
