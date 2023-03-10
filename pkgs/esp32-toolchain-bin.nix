{ stdenv, lib, fetchurl, glibc, gcc-unwrapped, python2 }:

stdenv.mkDerivation rec {
	pname = "gcc-xtensa-esp32-elf-bin";
	version = "2022r1";

	src = fetchurl {
		url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/xtensa-esp32-elf-gcc11_2_0-esp-${version}-linux-amd64.tar.xz";
		sha256 = "aY2EB+GCddGP630a/baIALl5BPvjkIBCL7hgmvpJ3zA=";
	};

	rpath = lib.makeLibraryPath [
		gcc-unwrapped
		glibc
		python2
	];

	installPhase = ''
		mkdir -p $out
		cp -r . $out
	'';

	postFixup = ''
		for FILE in $(ls $out/bin); do
			FILE_PATH="$out/bin/$FILE"
			patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $FILE_PATH || true
			patchelf --set-rpath ${rpath} $FILE_PATH || true
		done

		for FILE in $(ls $out/libexec/gcc/xtensa-esp32-elf/11.2.0); do
			FILE_PATH="$out/libexec/gcc/xtensa-esp32-elf/11.2.0/$FILE"
			patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $FILE_PATH || true
			patchelf --set-rpath ${rpath} $FILE_PATH || true
		done

		for FILE in $(ls $out/xtensa-esp32-elf/bin); do
			FILE_PATH="$out/xtensa-esp32-elf/bin/$FILE"
			patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $FILE_PATH || true
			patchelf --set-rpath ${rpath} $FILE_PATH || true
		done
	'';

	meta = with lib; {
		description = "ESP32 toolchain";
		homepage = "https://docs.espressif.com/projects/esp-idf/en/stable/get-started/linux-setup.html";
		license = licenses.gpl3;
	};
}

