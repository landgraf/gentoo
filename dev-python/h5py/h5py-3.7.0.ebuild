# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Simple Python interface to HDF5 files"
HOMEPAGE="
	https://www.h5py.org/
	https://github.com/h5py/h5py/
	https://pypi.org/project/h5py/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~riscv x86 ~amd64-linux ~x86-linux"
# disable mpi until mpi4py gets python3_8
#IUSE="examples mpi"
IUSE="examples"

#RDEPEND="sci-libs/hdf5:=[mpi=,hl(+)]
DEPEND="
	sci-libs/hdf5:=[hl(+)]
"
RDEPEND="
	${DEPEND}
	>=dev-python/numpy-1.14.5[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.14.5[${PYTHON_USEDEP}]
	dev-python/pkgconfig[${PYTHON_USEDEP}]
	test? (
		dev-python/QtPy[testlib,${PYTHON_USEDEP}]
	)
"
#	mpi? ( virtual/mpi )
#	mpi? ( dev-python/mpi4py[${PYTHON_USEDEP}] )

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/alabaster

#pkg_setup() {
#	use mpi && export CC=mpicc
#}

python_prepare_all() {
	# avoid pytest-mpi dep, we do not use mpi anyway
	sed -i -e 's:pytest-mpi::' pytest.ini || die
	distutils-r1_python_prepare_all

	export H5PY_SETUP_REQUIRES=0
}

python_test() {
	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die
	epytest -m "not mpi"
}

python_install_all() {
	use examples && dodoc -r examples
	distutils-r1_python_install_all
}
