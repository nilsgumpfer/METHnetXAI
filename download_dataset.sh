# Create dataset dir
mkdir ../METHnetDataset
cd ../METHnetDataset

# Download patient data
wget https://zenodo.org/records/6924901/files/Testset.csv

# Update filenames
#awk 'BEGIN{FS=OFS=","} NR==1 {print; next} {$1="B"$1; $2="B"$2; print}' Testset.csv > Testset.csv

# Create WSI dir
mkdir ./WSIs
cd ./WSIs

# Download files
wget https://zenodo.org/records/6924901/files/1-21_HE_Hamamatsu_40x.ndpi
wget https://zenodo.org/records/6924901/files/2-20_HE_Hamamatsu_40x.ndpi
wget https://zenodo.org/records/6924901/files/3-19_HE_Hamamatsu_40x.ndpi
wget https://zenodo.org/records/6924901/files/4-21_HE_Hamamatsu_40x.ndpi
wget https://zenodo.org/records/6924901/files/5-21_HE_Hamamatsu_40x.ndpi
wget https://zenodo.org/records/6924901/files/6-21_HE_Hamamatsu_40x.ndpi

# Rename all .ndpi files to start with "B"
#for f in *.ndpi; do
#    mv "$f" "B$f"
#done