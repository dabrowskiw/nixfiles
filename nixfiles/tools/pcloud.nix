{ pkgs-unstable, lib ? pkgs-unstable.lib, fetchzip ? pkgs-unstable.fetchzip, ... }:

pkgs-unstable.stdenv.mkDerivation rec {
  pname = "pcloudcc-lneely";
  version = "20250407T2152Z";

  src = fetchzip {
    url = "https://github.com/lneely/pcloudcc-lneely/archive/refs/tags/${version}.tar.gz";
    hash = "sha256-fddDF3jYqHNWC6/OubNMOMvQRZlIKaSLCRyi9ClFbgg";
  };

  buildInputs = with pkgs-unstable; [
    zlib
    sqlite
    boost
    libudev-zero
    readline
    fuse
    mbedtls
  ];

  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    make DESTDIR=$out install
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/lneely/pcloudcc-lneely";
    description = "pcloudcc-lneely is an independent fork of pcloud console client";
    longDescription = ''
      pcloudcc-lneely is a simple linux console client for pCloud 
      cloud storage, forked from github.com/pcloudcom/console-client 
      and independently maintained.
    '';
    license = licenses.mit;
    mainProgram = "pcloudcc";
    platforms = platforms.linux;
  };
}
