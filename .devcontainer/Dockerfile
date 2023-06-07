ARG PYTHON_VERSION=3.10.11
# ARG WORKSPACE=noworkspace
# https://hub.docker.com/_/python/tags?page=1

# Base Image
FROM python:${PYTHON_VERSION}
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# Other tools
RUN apt-get update && \
    apt-get install -y sudo \
    curl \
    silversearcher-ag \
    zsh \
    git \
    apt-utils

# set zsh config
ENV ROOT /root

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

COPY .zshrc $ROOT/.zshrc
ENV SHELL /bin/zsh
# Poetry setup
ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100

RUN pip3 install poetry
# Persist bash (WIP)
# RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/home/jens/.bash_history" \
#     && echo $SNIPPET >> "/root/.bashrc"
# isntall packages
# ENV WORKSPACE_NAME template-python-project/
# WORKDIR /workspaces/${WORKSPACE}
