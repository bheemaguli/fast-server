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

    echo "Installing frontend"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    nvm install 20
    NODE_VERSION=$(node -v)
    [[ $NODE_VERSION == "v20.13.0" ]]
    corepack enable pnpm
    echo "${NODE_VERSION} installed and pnpm enabled"
    echo "Installing frontend packages now"
    (cd "${SCRIPT_DIR}"/src/frontend && pnpm i)
else
    echo "Python version incompatible"
fi