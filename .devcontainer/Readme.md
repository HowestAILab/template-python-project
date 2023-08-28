# Devcontainer

This folder contains a devcontainer template

Before importing you need to run the devcontainer_creator. Run it from the root of the workspace

```bash
bash .devcontainer/devcontainer_creator.bash
```

You then need to follow the instructions in the terminal. Here you have an example:

```bash
What is the name of the workspace/folder?
template-python-project
Do you USE/have gpu in machine? (y/n - default)
n (or just press enter)
What is the python version? (default is 3.10.11)
3.10.11 (or just press enter)
```

If you have a GPU look good at the version of CUDA and CUDNN you have installed.

use `nvidia-smi` to get the cuda version from the server/device working on, if it is not installed install it from the [Nvidia site](https://developer.nvidia.com/cuda-downloads)

For the cudnn version you can look for a compatible version with your cuda installation at [Link](https://developer.nvidia.com/rdp/cudnn-archiv).

If any problems occur create an issue on the repo.

## Notes

##### Migration to GPU container from existing Non-GPU container

When you are migrating your container fully (including the .venv and poetry lock file) or you are changing the config from a NON-GPU to a GPU environment make sure to first remove the .venv and the poetry lock file

## Specific server configs

| Server | Cuda   | cudnn8 |
| ------ | ------ | ------ |
| A5000  | 11.6.0 | cudnn8 |
| Titan  | 11.4.0 | cudnn8 |

> **Important!** Do not forget the .0 on the end of the cuda version. This is a reference to the [docker images of Nvidia](https://hub.docker.com/r/nvidia/cuda/tags)
