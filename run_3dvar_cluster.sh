#!/bin/bash
#SBATCH --account=ubuntu
#SBATCH --job-name=fv3jedi
#SBATCH --output=log.cadre26.%j
#SBATCH --partition=compute
#SBATCH --qos=batch
#SBATCH --time=00:20:00
#SBATCH --ntasks=96

set -x

ulimit -s unlimited; ulimit -a;

# Parameters
# Path to JEDI bin direcoty: change this if you built this in another directory
JEDI_BIN_PATH="/home/ubuntu/GDASApp/build/bin"
# Path to input files (pre-staged)
JEDI_INPUT_PATH="/scratch/cadre26/input_data"
# Prefix of experimental case directory
EXP_NAME_BASE="cadre26"

cdir=$(pwd)
exp_dir_path="${cdir}/exp_case/${EXP_NAME_BASE}.${SLURM_JOB_ID}"

# Set up experimental case directory
mkdir -p ${exp_dir_path}

# Copy input YAML files
cp -r ${cdir}/input_yaml/jedi_3dvar_fv3* ${exp_dir_path}

# Sym-link input directories
ln -nsf ${JEDI_INPUT_PATH}/* ${exp_dir_path}

# Move to experimental case directory
cd ${exp_dir_path}

# Create output directory
mkdir -p output

# Load modules
module purge
module use /opt/spack-stack/envs/ue-oneapi-2024.2.1/install/modulefiles/Core
module load stack-oneapi/2024.2.1
module load py-scipy/1.14.1
module load scotch/7.0.4
module load stack-intel-oneapi-mpi/2021.13
module load global-workflow-env/1.0.0
module load jedi-fv3-env/1.0.0
module load jedi-base-env/1.0.0
module load libfabric-aws/2.1.0amzn2.0
module list

export OMP_NUM_THREADS=1
export OMP_PLACES=cores
export OMP_PROC_BIND=close

# Run FV3-JEDI
date
pgm="fv3jedi_var.x"
jedi_yaml="jedi_3dvar_fv3_2024022400.yaml"
srun -n 96 --mpi=pmi2 ${JEDI_BIN_PATH}/$pgm ${jedi_yaml} >>OUTPUT.fv3jedi 2>errfile_fv3jedi
export err=$?
if [[ $err != 0 ]]; then
  echo "FATAL ERROR: fv3-jedi failed."
  exit 1
fi
date
# Run JEDI executable for increment
pgm="gdas_fv3jedi_fv3inc.x"
jedi_inc_yaml="jedi_3dvar_fv3inc_2024022400.yaml"
srun -n 96 --mpi=pmi2 ${JEDI_BIN_PATH}/$pgm ${jedi_inc_yaml} >>OUTPUT.fv3inc 2>errfile_inc
export err=$?
if [[ $err != 0 ]]; then
  echo "FATAL ERROR: fv3-jedi increment failed."
  exit 1
fi
date
echo "===== FV3-JEDI completed successfully ====="
