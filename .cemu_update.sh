cd $HOME/Cemu
git pull --recurse-submodules
cmake -S . -B build -DCMAKE_BUILD_TYPE=release -DCMAKE_C_COMPILER=/usr/bin/clang-12 -DCMAKE_CXX_COMPILER=/usr/bin/clang++-12 -G Ninja -DCMAKE_MAKE_PROGRAM=/usr/bin/ninja \-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
cmake --build build
