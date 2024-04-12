#! /usr/bin/env bash

echo "Update valid.yml"
curl https://raw.githubusercontent.com/jetify-com/typeid/main/spec/valid.yml > spec/valid.yml

echo "Update invalid.yml"
curl https://raw.githubusercontent.com/jetify-com/typeid/main/spec/invalid.yml > spec/invalid.yml
