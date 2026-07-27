#!/bin/bash
export PATH=$PATH:/usr/local/go/bin
# Below handles tools installed via `go install`
# shellcheck disable=SC2155
export PATH="$PATH:$(go env GOPATH)/bin"
