#!/bin/bash
##
##  Script: gcc-build-vars.sh
##
##  This script sets configuration and build variables that are used by
##  all the other scripts.  It is intended to be called by other scripts.
##  It assumes that TOP_DIR has been defined appropriately by the caller,
##  and that it is being sourced by the calling script.
##
##- Customize this variable to specify the version of GCC 5 that you want
##  to download and build.
##
export GCC_VERSION=5.X.0

##- Customize variable this to name the installation; the custom name is
##  displayed when a user invokes gcc/g++ with the -v or --version flags.
##
export GCC_PKG_NAME='KEWB Enterprises Build'

##- Customize this variable to define the middle substring of the GCC build
##  triple.
##
export GCC_CUSTOM_BUILD_STR=kewb

##- Customize these variables to specify where this version of GCC will
##  be installed.
##
export GCC_INSTALL_ROOT=/usr/local
export GCC_INSTALL_DIR=$GCC_INSTALL_ROOT/gcc/$GCC_VERSION

##- Customize this variable to specify the installation's time stamp.
##
export GCC_TIME_STAMP=201606011000

##- Customize these variables if you want to change the arguments passed
##  to make that specify the number of threads used to build and test GCC,
##  respectively.
##
export GCC_BUILD_THREADS_ARG='-j8'
export GCC_TEST_THREADS_ARG='-j4'

##- Set this variable to YES if you want to embed the assember and linker
##  from a newer version of GNU Binutils (specified below) into the GCC
##  installation.  If you just want to use the system's assembler and linker,
##  then undefine this variable.
##
export GCC_USE_NEWER_BINUTILS=YES

##------------------------------------------------------------------------------
##      Maybe change below this line, if you have a good reason.
##------------------------------------------------------------------------------
##
##- Customize this variable if you want the gcc/g++ executables to be
##  built with a suffix in their names (e.g., gccfoo/g++foo). In general,
##  this is best left undefined.
##
export GCC_EXE_SUFFIX=

##- These variables define the versions of binutils, GMP, MPC, and MPFR
##  used to build GCC.
##
export BU_VERSION=2.26
export GMP_VERSION=5.1.3
export MPC_VERSION=1.0.3
export MPFR_VERSION=3.1.4

##------------------------------------------------------------------------------
##      Do not change below this line!
##------------------------------------------------------------------------------
##
export GCC_PLATFORM=`uname`

export GCC_TARBALL=gcc-$GCC_VERSION.tar.gz
export GMP_TARBALL=gmp-$GMP_VERSION.tar.gz
export MPC_TARBALL=mpc-$MPC_VERSION.tar.gz
export MPFR_TARBALL=mpfr-$MPFR_VERSION.tar.gz

if [ "$GCC_PLATFORM" == "Linux" ] && [ "$GCC_USE_NEWER_BINUTILS" == "YES" ]
then
    export BU_TARBALL=binutils-$BU_VERSION.tar.gz
    export BU_SRC_DIR=$TOP_DIR/binutils-$BU_VERSION
    export BU_BLD_DIR=$TOP_DIR/binutils-$BU_VERSION-build
fi

export ALL_TARBALLS="$GCC_TARBALL $GMP_TARBALL $MPC_TARBALL $MPFR_TARBALL $BU_TARBALL"

export GCC_TAG="${GCC_VERSION//.}"
export GCC_SRC_DIR=$TOP_DIR/gcc-$GCC_VERSION
export GCC_BLD_DIR=$TOP_DIR/gcc-$GCC_VERSION-build
export GCC_INSTALL_RELDIR=`echo $GCC_INSTALL_DIR | sed 's:^/::'`

export RPMBUILD_SRCDIR=$TOP_DIR/dist

if [ "$GCC_PLATFORM" == "FreeBSD" ]
then
    GCC_MAKE=gmake

elif [ "$GCC_PLATFORM" == "Linux" ]
then
    GCC_MAKE=make
else
    echo "Unknown build platform!"
    exit 1
fi