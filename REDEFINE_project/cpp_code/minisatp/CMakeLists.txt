#--------------------------------------------------------------------------------------------------
# Configurable options:
option(STATIC_BINARIES "Link binaries statically." ON)
option(USE_SORELEASE   "Use SORELEASE in shared library filename." ON)

#--------------------------------------------------------------------------------------------------
# Library version:

set(MINISATP_SOMAJOR   1)
set(MINISATP_SOMINOR   1)
set(MINISATP_SORELEASE 0)

# Compute VERSION and SOVERSION:
if(USE_SORELEASE)
  set(MINISATP_VERSION ${MINISATP_SOMAJOR}.${MINISATP_SOMINOR}.${MINISATP_SORELEASE})
else()
  set(MINISATP_VERSION ${MINISATP_SOMAJOR}.${MINISATP_SOMINOR})
endif()
set(MINISATP_SOVERSION ${MINISATP_SOMAJOR})

#--------------------------------------------------------------------------------------------------
# Compile flags:

add_definitions(-include Global.h -include Main.h -D_FILE_OFFSET_BITS=64)

#--------------------------------------------------------------------------------------------------
# Dependencies:

find_package(GMP REQUIRED)
include_directories(${GMP_INCLUDE_DIR})

include_directories(${CMAKE_SOURCE_DIR}/minisat
                    ${CMAKE_SOURCE_DIR}/minisatp
                    ${CMAKE_SOURCE_DIR}/minisatp/ADTs)

#--------------------------------------------------------------------------------------------------
# Build Targets:

set(MINISATP_LIB_SOURCES
    ADTs/FEnv.cc
    ADTs/File.cc
    ADTs/Global.cc
    Debug.cc
    Hardware_adders.cc
    Hardware_clausify.cc
    Hardware_sorters.cc
    Main.cc
    PbParser.cc
    PbSolver.cc
    PbSolver_convert.cc
    PbSolver_convertAdd.cc
    PbSolver_convertBdd.cc
    PbSolver_convertSort.cc)

add_library(minisatp ${MINISATP_LIB_SOURCES})

target_link_libraries(minisatp minisat)