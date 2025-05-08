# Histological methylation subtype classification with XAI

## System requirements
### Software dependencies
Most sofware dependencies are specified in the Docker File and requirements.txt. Additionally a installed version of [CUDA](https://developer.nvidia.com/cuda-toolkit) is needed to enable GPU Support. If you want to use [Docker](https://www.docker.com/) please make sure Docker is properly installed and additionally [nvidia-docker](https://github.com/NVIDIA/nvidia-docker).
The software was tested on a Linux Ubuntu Client. For visualization of Attention Maps [QuPath](https://qupath.github.io) is used. 
Additional package dependencies as defined in the Docker File are : [OpenSlide](https://openslide.org), [json](https://docs.python.org/3/library/json.html), [NumPy](https://numpy.org), [pandas](https://pandas.pydata.org), [pillow](https://python-pillow.org), [albumentations](https://albumentations.ai), [OpenCV](opencv.org/), [PyTorch](pytorch.org), [progress](https://pypi.org/project/progress/), [matplotlib](matplotlib.org), [scikit-learn](scikit-learn.org), [ptitprince](https://github.com/pog87/PtitPrince) and [seaborn](https://seaborn.pydata.org).
### Required hardware
The software was tested on a machine with 128 GB RAM and an Intel Core i9-10900K CPU @ 3.70GHz x 20 and Ubuntu 20.04.3 LTS 64bit installed.
For speeding up network training a GPU with CUDA support is needed. We tested this project on a Nvidia GeForce RTX 3090 graphics card with 24 GB. 

## Installation guide
We provide a guide on how to set up the project using Docker.
### Instructions
Inside the cloned repository, build the docker image, a container and connect to it by running:
```
bash create_container.sh
```

This builds the image and creates a container. A directory ```../METHnetDataset``` is created that will serve as a mapping to the working directory inside the container. 

### Demo
This is how to run an classification of Meningioma benign-1 vs. Meningioma intermediate-A based on the provided dataset from [zenodo](https://zenodo.org/record/6924901).

In the cloned METHnetXAI directory, run:
```
bash download_dataset.sh
```

This downloads the dataset from zenodo to the ```../METHnetDataset``` directory that has been mapped to the container. To connect to the container, run:

```
bash connect_to_container.sh
```

To start the demo, run this indide the container:

```
bash run_main.sh 
```

#### Patient information
|ID|Histological ID|WHO Grade|Methylation Classes Meningioma-Classifier|Methylation class family member (EPIC) Meningioma-Classifier|probability class| probability subclass|Age|Sex|
|---|---|---|---|---|---|---|---|---|
|B1-21|B1-21|Atypical Meningiom (WHO Grade 2)|Meningioma intermediate|Meningioma intermediate-A|0.85|0.84|80|Female|
|B2-21|B2-21|Meningiom (WHO Grade 1)|Meningioma benign|Meningioma benign-1|0.9|0.74|60|Male|
### Expected output
The demo will generate multiple files in the working directory (METHnetDataset).
#### Tiling
A JSON per Tiling performed. The naming scheme is the following
```
ID_Staining_Scanner_Magnificationx_UsedMagnification_SizeX_SizeY_OverlapX_OverlapY.json
```
The first four informations are the same as in the WSI. Used magnification is the image pyramid level used. Size describes Tile size in pixel and Overlap the amount of shared pixels between two adjacent Tiles.
The JSON holds information in this scheme with x and y describing the Tiles position:
```
{"tiles":[{"x":0,"y":0}]}
```
#### splits
Holds a .csv file per class and iteration of Monte-Carlo cross-validation to remember the order of random shuffling this is to ensure the same split in train/validation/test sets. Naming scheme is Iteration_ClassLabel.csv.
#### Features
Holds one folder per image property. Inside one file holding the encoded features per WSI are stored.
#### Models
Holds a file per model trained with its parameters.
#### Results
Holds predicted scores per patient.
#### Attention maps
Holds an attention map per patient in test set.
#### Attention statistics
Holds files relevant for attention statistics as described in the paper.
### Expected runtime
The demo run might take around 2 hours including tiling and feature encoding.
Depending wheter WSIs are stored on SSD or HDD and the system specs the runtime might differ.

## Credits
Parts of the network were adapted from
[CLAM](https://github.com/mahmoodlab/CLAM) by [mahmoodlab](https://github.com/mahmoodlab)

## License
This code is made available under the GPLv3 License and is available for non-commercial academic purposes.

## Funding
This work was funded by the German Federal Ministry of Education and Research: MIRACUM (BMBF FKZ 01ZZ1801) and AI-RON (BMBF FKZ 01ZZ2017).

## Reference
