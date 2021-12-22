#!/bin/bash

set -o xtrace

native-image \
  -jar ./target/server-1.0.jar \
  -H:ConfigurationFileDirectories=./assisted-config \
  -H:+ReportExceptionStackTraces \
  -H:+TraceNativeToolUsage \
  --allow-incomplete-classpath \
  --native-image-info \
  --verbose \
  --no-fallback \
  -H:+StaticExecutableWithDynamicLibC \
  --static