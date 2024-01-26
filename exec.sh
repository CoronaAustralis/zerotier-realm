#!/bin/sh
realm -c /realm.toml &

/entrypoint.sh $@

