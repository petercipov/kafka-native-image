#!/bin/bash

printf "ls brokers\nexit\n" | /kafka/metadata --snapshot /tmp/kraft-combined-logs/__cluster_metadata-0/00000000000000000000.log