# ---------


# Python-level module import
# (file: mpi4py/MPI.so)

from mpi4py import MPI

# Python-level objects and code

size  = MPI.COMM_WORLD.Get_size()
rank  = MPI.COMM_WORLD.Get_rank()
pname = MPI.Get_processor_name()

hwmess = "Hello, World! I am process %d of %d on %s."
print (hwmess % (rank, size, pname))



# ---------


# Cython-level cimport
# this make available mpi4py's Python extension types
# (file:  mpi4py/include/mpi4py.MPI.pxd)

from mpi4py.MPI cimport Comm as CommType
from mpi4py.MPI cimport Intracomm as IntracommType

# C-level cdef, typed, Python objects

cdef CommType WORLD = MPI.COMM_WORLD
cdef IntracommType SELF = MPI.COMM_SELF


# ---------


# Cython-level cimport with PXD file
# this make available the native MPI C API
# with namespace-protection (stuff accessed as mpi.XXX)
# (file: mpi4py/include/mpi4py.mpi_c.pxd)

cimport mpi4py.mpi_c as mpi

cdef mpi.MPI_Comm world1 = WORLD.ob_mpi

cdef int ierr1=0

cdef int size1 = 0
ierr1 = mpi.MPI_Comm_size(mpi.MPI_COMM_WORLD, &size1)

cdef int rank1 = 0
ierr1 = mpi.MPI_Comm_rank(mpi.MPI_COMM_WORLD, &rank1)

cdef int rlen1=0
cdef char pname1[mpi.MPI_MAX_PROCESSOR_NAME]
ierr1 = mpi.MPI_Get_processor_name(pname1, &rlen1)
pname1[rlen1] = 0 # just in case ;-)

hwmess = "Hello, World! I am process %d of %d on %s."
print (hwmess % (rank1, size1, pname1))


# ---------


# Cython-level include with PXI file
# this make available the native MPI C API
# without namespace-protection (stuff accessed as in C)
# (file: mpi4py/include/mpi4py/mpi.pxi)

include "mpi4py/mpi.pxi"

cdef MPI_Comm world2 = WORLD.ob_mpi

cdef int ierr2=0

cdef int size2 = 0
ierr2 = MPI_Comm_size(MPI_COMM_WORLD, &size2)

cdef int rank2 = 0
ierr2 = MPI_Comm_rank(MPI_COMM_WORLD, &rank2)

cdef int rlen2=0
cdef char pname2[MPI_MAX_PROCESSOR_NAME]
ierr2 = MPI_Get_processor_name(pname2, &rlen2)
pname2[rlen2] = 0 # just in case ;-)

hwmess = "Hello, World! I am process %d of %d on %s."
print (hwmess % (rank2, size2, pname2))


# ---------
