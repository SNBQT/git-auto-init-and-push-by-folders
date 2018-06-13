#!/bin/bash

rootPath=$PWD/projects
mkdir -p $rootPath
echo $rootPath
cd $rootPath

for i in {1..3}
do
  folder=Demo$i
  mkdir -p $folder
  echo $folder
done

for i in {4..5}
do
  folder=中文$i
  mkdir -p $folder
  echo $folder
done
