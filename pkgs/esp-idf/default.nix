{ stdenv, lib, fetchurl, fetchFromGitHub, python3, unzip }:

stdenv.mkDerivation rec {
	pname = "esp-idf";
	version = "v5.0.1";

	src = fetchFromGitHub {
		owner = "espressif";
		repo = pname;
		rev = version;
		sha256 = "kyCEoA8synodDfYdN8gq2/ezacxz5DFOD9wrPDZC89U=";
		fetchSubmodules = true;
	};

	constraints = fetchurl {
		url = "https://dl.espressif.com/dl/esp-idf/espidf.constraints.v5.0.txt";
		sha256 = "OsLODnQuUY7XZ4/iypHngtNYdjdcZC/q3Blbpb9/wfA=";
	};

	pythonEnv = ./pythonenv.zip;

	buildInputs = [ unzip ];
	propagatedBuildInputs = [
		python3
	];

	setupHook = ./setup-hook.sh;

	installPhase = ''
		mkdir -p $out
		cp -r $src/* $out/

		mkdir -p $out/espressif/python_env/idf5.0_py3.10_env
		
		echo '{"idfInstalled":{"esp-idf-v5.0":{"version":"5.0","path":"' > $out/espressif/idf-env.json
		echo "$out" >> $out/espressif/idf-env.json
		echo '","features":["core"],"targets":["esp32"]}}}' >> $out/espressif/idf-env.json

		unzip ${pythonEnv} -d $out/espressif/python_env/idf5.0_py3.10_env/

		cp ${constraints} $out/espressif/espidf.constraints.v5.0.txt
		ln -s $out/espressif/python_env/idf5.0_py3.10_env/lib $out/
	'';

	meta = with lib; {
		description = "ESP-IDF";
		homepage = "https://docs.espressif.com/projects/esp-idf/en/stable/get-started/linux-setup.html";
		license = licenses.gpl3;
	};
}

