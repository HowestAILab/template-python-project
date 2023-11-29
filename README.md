<h2 align="center">Python project template</h2>

<p align="center">
<a href="https://github.com/SmartTechAIResearch/template-python-project/actions/workflows/pre-commit.yaml"><img alt="Actions Status" src="https://github.com/SmartTechAIResearch/template-python-project/actions/workflows/pre-commit.yaml/badge.svg"></a>
<a href="https://github.com/SmartTechAIResearch/template-python-project/actions/workflows/version.yaml"><img alt="Actions Status" src="https://github.com/SmartTechAIResearch/template-python-project/blob/gh-pages/version.svg"></a>
<a href="https://github.com/SmartTechAIResearch/template-python-project/actions/workflows/version.yaml"><img alt="Actions Status" src="https://github.com/SmartTechAIResearch/template-python-project/blob/gh-pages/date.svg"></a>
<a href="https://github.com/SmartTechAIResearch/template-python-project/actions/workflows/version.yaml"><img alt="Actions Status" src="https://github.com/SmartTechAIResearch/template-python-project/blob/gh-pages/language.svg"></a>

</p>

##  -- IN MAINTENANCE -- Use the minimal version from the develop branch ##


-   [How to use](#how-to-use)
-   [Installation](#installation)
    -   [Poetry](#poetry)
    -   [Pre-commit](#pre-commit)
    -   [Usability](#usability)
    -   [Devcontainer](#devcontainer)
-   [Possible errors](#possible-errors)
    -   [Docker issues](#docker-issues)

## How to use

Some key things to know when developing in the devcontainer

You don't use git as normal, there is a whole pipeline in place to have a correct way of formatting your code. Use this in the terminal!

```bash
pc
```

this will run the pre-commit pipeline and format your code.
You then have to make a good commit message by selecting the correct type of commit and then writing a small description of what you have done.

It is high likely that code will be reformatted. this means you have to rerun the previous script but no panic, there is a shortcut for this

```bash
pcr
```

in full:

```bash
poetry commit retry
```

The shortcut is created inside the docker container .zshrc file, normally you should never have to use the full command. Other shortcuts can be found inside the pyproject.toml file.

Do this until you have a clean commit.

when you are done with your work you can push it to the repo with the following command

```bash
gp
```

in full:

```bash
git push
```

This will push your code to the repo.

## Installation

When starting the repo everything should be ready to use. (do not forget to install the devcontainer [Devcontainer readme](.devcontainer/Readme.md))

Here some info about the pre installed tools

### Poetry

poetry is a venv like solution. Instead of using conda or just the main python installation this makes a reusable, modular virtual environment.

### Pre-commit

Install pre-commit for better file cleaning before commitpip install pre-commit

### Usability

There are some shortcuts when in the poetry virtual environment `poetry shell` to make certain commands faster execute the following to see them

```bash
poe
```

Some other shortcuts that are already in the terminal config file

```bash
pos="poetry shell"
ga="git add ."
gp="git push"
pc="poe commit"
pcr="poe cretry"
```

### Devcontainer

You can see a folder named devcontainer. This is a [Docker](https://code.visualstudio.com/docs/devcontainers/containers) container made for developing inside.
By using this, it should be easier and faster to start developing, on a server, locally or just anywhere.

To get started install the repo in any folder and open it in VS-code

For more info about how to start look in: [Devcontainer readme](.devcontainer/Readme.md)

If you have followed the steps and **ONLY THEN** you can go to the next step

Next when you are inside Vs-code inside the repo press `CTRL + SHIFT + P` and select the following option

`Dev containers: Rebuild and reopen in container`

this will build the container and try to open them.

## Possible errors

### Docker issues

#### WSL2 - docker not running

When you are working inside WSL2 and you get the following error

`Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?`

There are 2 things you can try to fix it

1.  Install docker inside WSL2 (if you have not done this already)
2.  Start the docker daemon inside WSL=> `sudo dockerd`

#### Server - config file not found

When you are working on the server and you don't have acces to the docker config located at the user folder

    WARNING: Error loading config file: /home/user/.docker/config.json ....

This can be fixed by running the following commands (before rebuilding the devcontainer)

```bash
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "/home/$USER/.docker" -R
```
