#!/bin/bash

docker build -t gidobot/blueos-core:master \
    --build-arg GIT_DESCRIBE_TAGS="$(git describe --long --always --dirty --all)" \
    --build-arg VITE_APP_GIT_DESCRIBE="$(git describe --long --always --dirty --all)" \
    core/
