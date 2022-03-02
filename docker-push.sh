docker images
docker login
docker tag python:Redis-requests eleigle/python:Redis-requests
docker push eleigle/python:Redis-requests
docker tag node:express-redis eleigle/node:express-redis
docker push eleigle/node:express-redis
docker tag python:Flask eleigle/python:Flask
docker push eleigle/python:Flask
docker tag ruby:sinatra-thin eleigle/ruby:sinatra-thin
docker push eleigle/ruby:sinatra-thin
