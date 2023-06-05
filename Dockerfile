# Using the Tensorflow GPU image as base
FROM tensorflow/tensorflow:latest-gpu

# Set the working directory to /app
WORKDIR /app

# Copy the requirements.txt file into the working directory
COPY requirements.txt .

# Set the environment variables
ENV PIP_ROOT_USER_ACTION=ignore

# Install system libraries required for OpenCV
RUN apt-get update && apt-get install -y \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1-mesa-glx

# Install the required Python libraries
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    jupyter server --generate-config && \
    printf "c.ServerApp.token = 'secret'\nc.ServerApp.password = ''\nc.ServerApp.open_browser = False\nc.ServerApp.ip = '0.0.0.0'\nc.ServerApp.port = 8888\n" >> ~/.jupyter/jupyter_server_config.py

# Expose the Jupyter port
EXPOSE 8888

# Run the Jupyter server
CMD ["jupyter", "server", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]