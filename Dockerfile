# Using the Tensorflow GPU image as base
FROM tensorflow/tensorflow:latest-gpu

# Set the working directory to /app
WORKDIR /app

# Copy the requirements.txt file into the working directory
COPY requirements.txt .

# Set the environment variables
ENV PIP_ROOT_USER_ACTION=ignore

# Install project libraries and configure jupyter server 
RUN apt-get update && apt-get install -y \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1-mesa-glx \
    curl \
    gnupg \
    nvidia-container-toolkit && \
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add - && \
    curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    jupyter server --generate-config && \
    printf "c.ServerApp.token = 'secret'\nc.ServerApp.password = ''\nc.ServerApp.open_browser = False\nc.ServerApp.ip = '0.0.0.0'\nc.ServerApp.port = 8888\n" >> ~/.jupyter/jupyter_server_config.py

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run jupyter server when the container launches
CMD ["jupyter", "server", "--allow-root"]