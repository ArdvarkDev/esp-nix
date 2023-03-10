
addIdfEnvVars() {
	if [ -e "$1/tools/idf.py" ]; then
		export IDF_PATH="$1"
		export IDF_TOOLS_PATH="$1/espressif"
		export IDF_PYTHON_ENV_PATH="$IDF_PATH/espressif/python_env"
		. $IDF_PYTHON_ENV_PATH/idf5.0_py3.10_env/bin/activate
		addToSearchPath PATH "$IDF_PATH/tools"
	fi
}

addEnvHooks "$hostOffset" addIdfEnvVars
