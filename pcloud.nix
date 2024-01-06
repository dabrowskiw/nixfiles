with import <nixpkgs> {}; # bring all of Nixpkgs into scope

stdenv.mkDerivation rec {
  pname = "pcloudcc";
  version = "2.0.1";

  src = fetchgit {
    url = "https://github.com/pcloudcom/console-client.git";
    rev = "4b42e3c8a90696ca9ba0a7e162fcbcd62ad2e306";
    sha256 = "sha256-9ccpIuWq8nV34GQac+b8CtGHTtSOAxpI/2h1i4AI97M=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    boost183
    cmake
    zlib
    fuse
    udev
  ];


  configurePhase = ''
  cd pCloudCC/lib/pclsync/
  make clean
  '';

  buildPhase = ''
  make fs
  cd ../mbedtls
  cmake .
  make clean
  make
  cd ../..
  sed -i.bak 's/Boost_USE_STATIC_LIBS ON/Boost_USE_STATIC_LIBS OFF/g' CMakeLists.txt
  rm CMakeLists.txt.bak
  cmake -DCMAKE_INSTALL_PREFIX=$out .
  make
  '';

  installPhase = ''
  mkdir -p $out/bin
  make install
#  ldconfig
  '';
}
