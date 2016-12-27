#!/usr/bin/env bash

# Run fpm-cook in all directories with a FPM Cookery recipe.

for i in $( ls -d */recipe.rb ); do
  pushd `dirname "${i}"`
  fpm-cook
  popd >/dev/null
done 
