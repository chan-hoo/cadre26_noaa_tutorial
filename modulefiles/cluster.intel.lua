help([[
Load environment for running the GDAS application with Intel compilers and MPI.
]])

prepend_path("MODULEPATH", "/opt/spack-stack/envs/ue-oneapi-2024.2.1/install/modulefiles/Core")

load("stack-oneapi/2024.2.1")
load("stack-intel-oneapi-mpi/2021.13")

load("py-scipy/1.14.1")
load("scotch/7.0.4")
load("global-workflow-env/1.0.0")
load("jedi-fv3-env/1.0.0")
load("jedi-base-env/1.0.0")
load("libfabric-aws/2.1.0amzn2.0")

local mpiexec = '/opt/intel/mpi/2021.13/bin/mpiexec'
local mpinproc = '-n'
setenv('MPIEXEC_EXEC', mpiexec)
setenv('MPIEXEC_NPROC', mpinproc)
