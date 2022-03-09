set -x

# Instrucciones para despliegue sin contenerizacion

# Instrucciones de depliegue de hasher
gem install sinatra

sudo tee -a /etc/hosts 0<<FINAL
#hasher
127.0.0.1 hasher
FINAL

ruby ./hasher/hasher.rb &

# Instrucciones depliegue redis
sudo yum install -y redis

sudo tee -a /etc/hosts 0<<FINAL
#redis
127.0.0.1 redis
FINAL

sudo systemctl start redis.service

# Instrucciones para desplegar rng
pip install Flask

sudo tee -a /etc/hosts 0<<FINAL
#rng
127.0.0.1 rng
FINAL

python ./rng/rng.py &

# Instrucciones para desplegar el worker
pip install redis requests

python ./worker/worker.py &

# Instrucciones para instalar webUI
npm i express redis@3.1.2

cd ./webui && node webui.js &

set +x
