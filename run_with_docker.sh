#!/bin/bash
docker build -t ruby-dev-random -f Dockerfile .
docker run -it --rm ruby-dev-random