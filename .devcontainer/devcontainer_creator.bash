# CREATE DEV CONTAINER BASED BY ASKING THE FOLLOWING QUESTIONS TO USER
# 1. What is the name of the workspace/folder?
# 2. Do you USE/have gpu in machine? (y/n)
# 3. What is the python version? (3.6/3.7/3.8)
# 4. What is the cuda version? (10.1/10.2/11.0)
default_python_version=$(awk -F "=" '/default_python_version/ {print $2}' .devcontainer/config.ini | tr -d ' ')
default_cuda=$(awk -F "=" '/default_cuda/ {print $2}' .devcontainer/config.ini | tr -d ' ')
default_cudnn=$(awk -F "=" '/default_cudnn/ {print $2}' .devcontainer/config.ini | tr -d ' ')
default_gpu_available=$(awk -F "=" '/default_gpu_available/ {print $2}' .devcontainer/config.ini | tr -d ' ')
default_ubuntu_version=$(awk -F "=" '/default_ubuntu_version/ {print $2}' .devcontainer/config.ini | tr -d ' ')

bold=$(tput bold)
normal=$(tput sgr0)

# 1. What is the name of the workspace/folder?
echo "${bold}What is the name of the workspace/folder?${normal}"
read workspace_name

# 2. Do you USE/have gpu in machine? (y/n)
echo "${bold}Do you USE/have gpu in machine? (y/n - default is ${default_gpu_available})${normal}"
read gpu

if [ -z "$gpu" ]; then
    gpu="${default_gpu_available}"
fi

# 3. What is the python version? (3.6/3.7/3.8)
echo "${bold}What is the python version? (default is ${default_python_version})${normal}"
read python_version
if [ -z "$python_version" ]; then
    python_version="${default_python_version}"
fi
next_python_version=$(echo ${python_version} | awk -F '.' '{print $1"."$2+1}')
current_python_version=$(echo ${python_version} | awk -F '.' '{print $1"."$2}')

# 4. What is the cuda version? (11 is default) (only ask if gpu is true)
if [ "$gpu" = "y" ]; then
    echo "${bold}What is the cuda version? (${default_cuda} default)${normal}"
    read cuda_version
fi
if [ -z "$cuda_version" ]; then
    cuda_version="${default_cuda}"
fi
# 4. What is the cuddn version? (10.1/10.2/11.0) (only ask if gpu is true)
if [ "$gpu" = "y" ]; then
    echo "${bold}What is the cuddn version? (${default_cudnn} default)${normal}"
    read cuddn_version
fi
if [ -z "$cuddn_version" ]; then
    cuddn_version="${default_cudnn}"
fi

# what is ubuntu version
if [ "$gpu" = "y" ]; then
    echo "${bold}What is the ubuntu version? (${default_ubuntu_version} default)${normal}"
    read ubuntu_version
fi
if [ -z "$ubuntu_version" ]; then
    ubuntu_version="${default_ubuntu_version}"
fi



# 5. Create devcontainer.json and save it in .devcontainer folder
echo "${bold}Creating devcontainer.json${normal}"
# if gpu is true
if [ "$gpu" = "y" ]; then
echo "{
    \"name\": \"${workspace_name}\",
    \"build\": {
        \"dockerfile\": \"DockerfileGPU\",
        \"args\": {
            \"PYTHON_VERSION\": \"${python_version}\",
            \"CUDA\":\"${cuda_version}\",
            \"CUDNN\":\"${cuddn_version}\"
            \"UBUNTU_VERSION\":\"${ubuntu_version}\"
        }
    },
    \"extensions\": [
        \"adpyke.codesnap\",
        \"analytic-signal.preview-mp4\",
        \"anseki.vscode-color\",
        \"cweijan.vscode-office\",
        \"esbenp.prettier-vscode\",
        \"GitHub.copilot\",
        \"GitHub.copilot-chat\",
        \"GitHub.vscode-pull-request-github\",
        \"Gruntfuggly.todo-tree\",
        \"hancel.markdown-image\",
        \"hbenl.vscode-test-explorer\",
        \"IronGeek.vscode-env\",
        \"KevinRose.vsc-python-indent\",
        \"maciejdems.add-to-gitignore\",
        \"magicstack.MagicPython\",
        \"magson.material-dark-color-theme\",
        \"mhutchie.git-graph\",
        \"mrmlnc.vscode-remark\",
        \"ms-python.isort\",
        \"ms-python.python\",
        \"ms-python.vscode-pylance\",
        \"ms-toolsai.jupyter\",
        \"ms-toolsai.jupyter-keymap\",
        \"ms-toolsai.jupyter-renderers\",
        \"ms-toolsai.vscode-jupyter-cell-tags\",
        \"ms-toolsai.vscode-jupyter-slideshow\",
        \"ms-vsliveshare.vsliveshare\",
        \"naumovs.color-highlight\",
        \"njpwerner.autodocstring\",
        \"PKief.markdown-checkbox\",
        \"PKief.material-icon-theme\",
        \"Postman.postman-for-vscode\",
        \"quicktype.quicktype\",
        \"RandomFractalsInc.vscode-data-preview\",
        \"ritwickdey.LiveServer\",
        \"ruiquelhas.vscode-lowercase\",
        \"Shinotatwu-DS.file-tree-generator\",
        \"sleistner.vscode-fileutils\",
        \"sourcery.sourcery\",
        \"streetsidesoftware.code-spell-checker\",
        \"swyphcosmo.spellchecker\",
        \"TakumiI.markdowntable\",
        \"tomoki1207.pdf\",
        \"tonybaloney.vscode-pets\",
        \"VisualStudioExptTeam.intellicode-api-usage-examples\",
        \"VisualStudioExptTeam.vscodeintellicode\",
        \"wix.vscode-import-cost\",
        \"yzane.markdown-pdf\"
    ],
    \"features\": {
        \"azure-cli\": \"latest\",
        \"github-cli\": \"latest\"
    },
    \"runArgs\": [
        \"--gpus\",
        \"all\",
        \"--name\",
        \"${workspace_name}_devcontainer\"
    ],
    \"postStartCommand\": \"poetry config virtualenvs.create true && poetry config virtualenvs.in-project true && poetry install --with cleaning,utils,gpu && poetry run pre-commit install\"
}" > .devcontainer/devcontainer.json

# change every mention of 3.10 to current_python_version in the dockerfileGPU
sed -i "s/3.10/${current_python_version}/g" .devcontainer/DockerfileGPU


# else
else
echo "{
    \"name\": \"${workspace_name}\",
    \"build\": {
        \"dockerfile\": \"Dockerfile\",
        \"args\": {
            \"PYTHON_VERSION\": \"${python_version}\"
        }
    },
    \"extensions\": [
        \"adpyke.codesnap\",
        \"analytic-signal.preview-mp4\",
        \"anseki.vscode-color\",
        \"cweijan.vscode-office\",
        \"esbenp.prettier-vscode\",
        \"GitHub.copilot\",
        \"GitHub.copilot-chat\",
        \"GitHub.vscode-pull-request-github\",
        \"Gruntfuggly.todo-tree\",
        \"hancel.markdown-image\",
        \"hbenl.vscode-test-explorer\",
        \"IronGeek.vscode-env\",
        \"KevinRose.vsc-python-indent\",
        \"maciejdems.add-to-gitignore\",
        \"magicstack.MagicPython\",
        \"magson.material-dark-color-theme\",
        \"mhutchie.git-graph\",
        \"mrmlnc.vscode-remark\",
        \"ms-python.isort\",
        \"ms-python.python\",
        \"ms-python.vscode-pylance\",
        \"ms-toolsai.jupyter\",
        \"ms-toolsai.jupyter-keymap\",
        \"ms-toolsai.jupyter-renderers\",
        \"ms-toolsai.vscode-jupyter-cell-tags\",
        \"ms-toolsai.vscode-jupyter-slideshow\",
        \"ms-vsliveshare.vsliveshare\",
        \"naumovs.color-highlight\",
        \"njpwerner.autodocstring\",
        \"PKief.markdown-checkbox\",
        \"PKief.material-icon-theme\",
        \"Postman.postman-for-vscode\",
        \"quicktype.quicktype\",
        \"RandomFractalsInc.vscode-data-preview\",
        \"ritwickdey.LiveServer\",
        \"ruiquelhas.vscode-lowercase\",
        \"Shinotatwu-DS.file-tree-generator\",
        \"sleistner.vscode-fileutils\",
        \"sourcery.sourcery\",
        \"streetsidesoftware.code-spell-checker\",
        \"swyphcosmo.spellchecker\",
        \"TakumiI.markdowntable\",
        \"tomoki1207.pdf\",
        \"tonybaloney.vscode-pets\",
        \"VisualStudioExptTeam.intellicode-api-usage-examples\",
        \"VisualStudioExptTeam.vscodeintellicode\",
        \"wix.vscode-import-cost\",
        \"yzane.markdown-pdf\"
    ],
    \"features\": {
        \"azure-cli\": \"latest\",
        \"github-cli\": \"latest\"
    },
    \"runArgs\": [
        \"--name\",
        \"${workspace_name}_devcontainer\"
    ],
    \"postStartCommand\": \"poetry config virtualenvs.create true && poetry config virtualenvs.in-project true && poetry install --with cleaning,utils && poetry run pre-commit install\"

}" > .devcontainer/devcontainer.json
fi

# 4. change the 15th line inside the pyproject.toml file to the name of the workspace
sed -i "15s/.*/name = \"${workspace_name}\"/" pyproject.toml
# create a next_pythen version variabele that is made of the first item of the python version than a dot and the second item of the python version +1 (split on dots)

# 5. change line 23 inside the pyproject.toml file to the python version
sed -i "23s/.*/python = \">=${current_python_version},<${next_python_version}\"/" pyproject.toml
