#Install conda env
conda env create -f environment.yml

wait
conda activate umol
pip install --upgrade "jax[cuda12_local]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
conda deactivate

## Get network parameters for Umol (a few minutes)
#Pocket params
wget https://zenodo.org/records/10397462/files/params40000.npy
mkdir data/params
mv params40000.npy  data/params/params_pocket.npy
#No-pocket params
wget https://zenodo.org/records/10489242/files/params60000.npy
mv params60000.npy  data/params/params_no_pocket.npy

wait
## Install HHblits (a few minutes)
git clone https://github.com/soedinglab/hh-suite.git
mkdir -p hh-suite/build && cd hh-suite/build
cmake -DCMAKE_INSTALL_PREFIX=. ..
make -j 4 && make install
cd ../..

wait
