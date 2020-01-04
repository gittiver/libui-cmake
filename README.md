# libui-cmake
libui lib build with cmake instead of meson 

we dont use the approach from https://github.com/matusnovak/libui-cmake using git-modules, 
instead libui sources are loaded by cmake itself via FetchContent

currently only works for OSX

# TODO #

- build for Linux/GTK
- build for Windows
- add option for using local Libui src (for fixing in libui sources)
