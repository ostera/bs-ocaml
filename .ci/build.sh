#!/bin/bash -e

#
# Build the project using the standard Makefile flows
#
build_with_make() {
  case $XARCH in
  i386)
    ./configure
    make world.opt
    sudo make install
    (cd testsuite && make all)
    git clone git://github.com/ocaml/camlp4 -b 4.02
    (cd camlp4 && ./configure && make && sudo make install)
    git clone git://github.com/ocaml/opam
    (cd opam && ./configure && make lib-ext && make && sudo make install)
    opam init -y -a git://github.com/ocaml/opam-repository
    opam install -y utop
    ;;
  *)
    echo unknown arch
    exit 1
    ;;
  esac
}

#
# Build the project relying on Esy
#
build_with_esy() {
  ESY=$(npm bin)/esy
  ${ESY} install
  ${ESY} build
}

if [[ ${ESY_BUILD} ]]; then
  echo "Found esy build..."
  build_with_esy()
else
  echo "Found c build..."
  build_with_make()
fi
