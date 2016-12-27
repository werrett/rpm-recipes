#!/usr/bin/env bash

# Run fpm-cook clean in all directories with a FPM Cookery recipe.

for i in $( ls -d */recipe.rb ); do
  pushd `dirname "${i}"`
  fpm-cook clean
  popd >/dev/null
done 
