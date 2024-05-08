#!/bin/bash

# https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

PYTHON_VERSION=$(python --version)
echo "${PYTHON_VERSION}"

if [[ $PYTHON_VERSION == "Python 3.12.3" ]]; then
    echo "Creating local environment"
    pip install uv==0.1.41
    uv venv
    source "${SCRIPT_DIR}"/.venv/bin/activate
    echo "Installing packages"
    uv pip install -r "${SCRIPT_DIR}"/requirements/dev.txt
else
    echo "Python version incompatible"
fi