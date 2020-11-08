#!/bin/bash

TODAY=`date +%m.%d`

docker build -t shoepping/hybris-tools:${TODAY} ./
