FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-runtime

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cmake \
    python3-dev \
    tzdata \
    openslide-tools \
    python3-openslide \
    libgl1-mesa-glx \
    git \
    build-essential && \
    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /code_rev

# Copy repo contents
COPY . .

# Install pip packages using requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

CMD ["/bin/bash"]
