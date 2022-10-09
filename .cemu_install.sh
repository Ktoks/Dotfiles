sudo apt install -y git curl cmake ninja-build nasm libgtk-3-dev libsecret-1-dev libgcrypt20-dev libsystemd-dev freeglut3-dev libpulse-dev clang-12
sudo apt install -y libspeexdsp-dev libspeexdsp1
git clone --recursive https://github.com/cemu-project/Cemu
cd Cemu
cmake -S . -B build -DCMAKE_BUILD_TYPE=release -DCMAKE_C_COMPILER=/usr/bin/clang-12 -DCMAKE_CXX_COMPILER=/usr/bin/clang++-12 -G Ninja -DCMAKE_MAKE_PROGRAM=/usr/bin/ninja
cmake --build build
echo "alias Cemu='$HOME/Cemu/Cemu_release'" >> $HOME/.zshrc
