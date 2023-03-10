
addIdfEnvVars() {
	if [ -e "$1/tools/idf.py" ]; then
		export IDF_PATH="$1"
		export IDF_TOOLS_PATH="$1/espressif"
		addToSearchPath PATH "$IDF_PATH/tools"
	fi
}

addEnvHooks "$hostOffset" addIdfEnvVars
