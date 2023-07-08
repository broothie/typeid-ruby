#! /usr/bin/env bash

echo "Update valid.yml"
curl https://api.github.com/repos/jetpack-io/typeid/contents/spec/valid.yml \
  -H 'Accept: application/vnd.github.raw' \
  > spec/valid.yml

echo "Update invalid.yml"
curl https://api.github.com/repos/jetpack-io/typeid/contents/spec/invalid.yml \
  -H 'Accept: application/vnd.github.raw' \
  > spec/invalid.yml
