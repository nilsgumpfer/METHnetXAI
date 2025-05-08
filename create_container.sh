docker build -t methnet:latest .
docker run -it -d -v $(realpath ../METHnetDataset):/data --gpus all --name $(whoami)_methnet methnet:latest bash