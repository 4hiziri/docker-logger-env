#!/bin/bash

docker run -d -p 9200:9200 --ip 172.17.0.2 --name elasticsearch elasticsearch
