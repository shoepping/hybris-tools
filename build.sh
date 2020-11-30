#!/bin/bash

TODAY=`date +%y.%m.%d`

docker build -t shoepping/hybris-tools:${TODAY} ./
