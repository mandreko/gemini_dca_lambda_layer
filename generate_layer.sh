#!/bin/sh

rm layer.zip
docker run --rm --volume=$(pwd):/lambda-build -w=/lambda-build lambci/lambda:build-python3.8 pip install -r requirements.txt --target python
zip -r layer python/
