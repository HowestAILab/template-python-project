#!/bin/bash

# Function to create environment for PyTorch
create_pytorch_venv() {
    echo "⚙️  Creating PyTorch environment..."
    poetry add torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
    echo "✅ PyTorch environment setup complete."
}

# Function to create environment for TensorFlow
create_tensorflow_venv() {
    echo "⚙️  Creating TensorFlow environment..."
    poetry add tensorflow[and-cuda]==2.17.0
    echo "✅ TensorFlow environment setup complete."
}

# Allow running of Jupyter Notebook cells with global Python environment
clear
echo "⚙️  Configuring environment..."
python -m pip install poetry
poetry add ipykernel black pylint pandas
poetry install
alias "pip install"="poetry add"
alias "pip install -r"="xargs poetry add <"

# Ask if the user wants to create a PyTorch environment
echo ""
read -p "❓ Does your project require PyTorch or Tensorflow? (pt/tf): " framework
if [[ "$framework" == "tf" ]]; then
  create_tensorflow_venv
else
  create_pytorch_venv
fi

# Finished
echo ""
echo "😀 Setup completed, good luck with your project!"
echo ""