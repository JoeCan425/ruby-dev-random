# /dev/random in Ruby

This repo contains an implementation of Unix's [/dev/random](https://en.wikipedia.org/wiki//dev/random) written in Ruby.

I found this [example](https://github.com/feulf/python-dev-random) in python and used it as a template.

The code can be run using docker or using ruby directly.

## Docker Setup (Recommended)

For docker, either run the script `./run_with_docker.sh` which will build the image and run it for you or run the follwing commands:

`docker build -t ruby-dev-random -f Dockerfile .` will build the image for you.
`docker run -it --rm ruby-dev-random` will start a container and kickoff the ruby script.

## Ruby Setup

For ruby, you will need ruby and bundler installed. Then run the following:

`bundle install` to install the vmstat gem.
`./main.rb` to run the script.