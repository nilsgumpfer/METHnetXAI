# Use specific PyTorch + CUDA base image
FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-runtime

# Prevent interactive prompts (e.g., tzdata)
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /code_rev

# Install system-level dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libgl1-mesa-glx \
    git \
    tzdata \
    openslide-tools \
    python3-openslide && \
    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy Python dependencies
COPY requirements.txt .

# Uninstall conflicting OpenCV packages and install cleanly
RUN pip uninstall -y opencv-python opencv-python-headless opencv-contrib-python || true && \
    pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Default command
CMD ["/bin/bash"]
