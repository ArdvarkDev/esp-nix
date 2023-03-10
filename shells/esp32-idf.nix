{ pkgs ? import ../default.nix }:

pkgs.mkShell {
	name = "esp-idf";

	buildInputs = with pkgs; [
		gcc-xtensa-esp32-elf-bin
		esp-idf
		esptool

		git
		wget

		flex
		bison
		gperf
		pkgconfig

		gnumake
		ninja
		cmake

		ncurses5
	];
}
