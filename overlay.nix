final: prev:
{
	gcc-xtensa-esp32-elf-bin = prev.callPackage ./pkgs/esp32-toolchain-bin.nix {};

	esp-idf = prev.callPackage ./pkgs/esp-idf {};
}
