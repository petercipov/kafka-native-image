#!/bin/bash

native-image \
  -jar ./target/server-1.0.jar --allow-incomplete-classpath \
  -J--add-exports=java.management/sun.management=ALL-UNNAMED \
  -H:ReflectionConfigurationFiles=./reflection-config.json \
  -H:ResourceConfigurationFiles=./resource-config.json \
  --static