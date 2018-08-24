#!/bin/bash

docker run -it -p 2055:2055 -p 2055:2055/udp --net=host -v $(pwd)/netflow-log:/fluentd/netflow-log logger
