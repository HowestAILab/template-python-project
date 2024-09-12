#!/bin/bash

# Get the current Python version
PYTHON_VERSION=$(python -c 'import platform; print(platform.python_version())')
CURRENT_PYTHON_VERSION=$(echo ${PYTHON_VERSION} | awk -F '.' '{print $1"."$2}')
# Create symbolic links for TensorRT
# cd .venv/lib/python$CURRENT_PYTHON_VERSION/site-packages/tensorrt && ln -s libnvinfer_plugin.so.8 libnvinfer_plugin.so.7 && ln -s libnvinfer.so.8 libnvinfer.so.7

# update the LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/workspaces/template-python-project/.venv/lib/python$CURRENT_PYTHON_VERSION/site-packages/tensorrt
