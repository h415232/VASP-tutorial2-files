#! /bin/bash
##PBS -N
#PBS -q exercise
##PBS -l nodes=1

source /submit/bin/node.sh

cd $PBS_O_WORKDIR

if [ -e INCAR ];then
    ##########
    ## VASP ##
    ##########
    module load vasp/5.4.4.18Apr17.huang
    mpiexec.hydra -rmk pbs -np ${MPIEXEC_NP} vasp_std
elif [ -e wannier90.win ];then
    #############
    ## Wannier ##
    #############
    module load vasp/5.4.4.18Apr17.huang
    wannier90.x wannier90
    #postw90.x wannier90
elif [ -e wt.in ];then
    ###################
    ## Wannier-Tools ##
    ###################
    module load wannier-tools/default
    export OPENBLAS_NUM_THREADS=1
    mpiexec.hydra -rmk pbs -np ${MPIEXEC_NP} wt.x
    #export OPENBLAS_NUM_THREADS=${MPIEXEC_NP}
    #wt.x
elif [ -e wann.in ];then
    module load wannier-tools/default
    symmhr_addrptblock.py
fi


