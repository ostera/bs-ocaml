#!/bin/bash -e

if [[ ${ESY_BUILD} ]]; then
  npm --global install esy@0.5.x
fi
