#!/bin/bash

set -e
# set -x

# get date to name the bin directory appropriately
date=$(date "+%d-%m-%Y");
mkdir -p ~/Downloads/bins_"${date}";

python3 -m pip install --upgrade pip
sudo apt update
sudo apt dist-upgrade -y
flatpak update -y --noninteractive

rustup update
cargo install-update -a

printf "new cpu targets can be found by using: rustc --print=target-cpus\n\n"



cd ~/Code/neovim/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "Neovim up-to-date\n\n"
else
  echo "I'm about to update Neovim - stop me if you aren't ready"
  sleep 5
  git pull
  rm -rf build/
  make CMAKE_BUILD_TYPE=Release
  sudo make install
fi

cd ~/Code/ripgrep
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
    printf "Ripgrep up-to-date\n\n"
else
  echo "I'm about to update Ripgrep - stop me if you aren't ready"
  sleep 5
  git pull
  # RUSTFLAGS="-C target-cpu=native" cargo +nightly build --release --features 'pcre2'
  # cargo clean
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release --features 'pcre2'
  cp ~/Code/ripgrep/target/x86_64-unknown-linux-musl/release/rg ~/Downloads/bins_"${date}"/rg_skylake_musl
  cargo clean
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/ripgrep/target/x86_64-unknown-linux-musl/release/rg ~/Downloads/bins_"${date}"/rg_skylake-avx512_musl
  cargo clean
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release --features 'pcre2'
  cp ~/Code/ripgrep/target/x86_64-unknown-linux-musl/release/rg ~/Downloads/bins_"${date}"/rg_sandybridge_musl
  cargo clean

  # may not work...
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release --features 'pcre2'
  cp ~/Code/ripgrep/target/release/rg ~/Downloads/bins_"${date}"/rg_skylake
  cargo clean
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  cp ~/Code/ripgrep/target/release/rg ~/Downloads/bins_"${date}"/rg_skylake-avx512
  cargo clean
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release --features 'pcre2'
  cp ~/Code/ripgrep/target/release/rg ~/Downloads/bins_"${date}"/rg_sandybridge
  cargo clean
fi

cd ~/Code/fd/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
    printf "FD-Find up-to-date\n\n"
else
  echo "I'm about to update FD-Find - stop me if you aren't ready"
  sleep 5
  git checkout -- .
  git pull
  RUSTFLAGS="-C target-cpu=native" cargo +nightly build --release
  cargo clean
  cargo add proc-macro2
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/fd/target/x86_64-unknown-linux-musl/release/fd ~/Downloads/bins_"${date}"/fd_skylake_musl
  cargo clean
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/fd/target/x86_64-unknown-linux-musl/release/fd ~/Downloads/bins_"${date}"/fd_skylake-avx512_musl
  cargo clean
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/fd/target/x86_64-unknown-linux-musl/release/fd ~/Downloads/bins_"${date}"/fd_sandybridge_musl
  cargo clean
  # may not work...
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/fd/target/release/fd ~/Downloads/bins_"${date}"/fd_skylake
  cargo clean
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/fd/target/release/fd ~/Downloads/bins_"${date}"/fd_skylake-avx512
  # cargo clean
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/fd/target/release/fd ~/Downloads/bins_"${date}"/fd_sandybridge
  cargo clean
fi

cd ~/Code/procs
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
    printf "Procs up-to-date\n\n"
else
  echo "I'm about to update Procs - stop me if you aren't ready"
  sleep 5
  git checkout -- .
  git pull
  cargo add rust_decimal
  RUSTFLAGS="-C target-cpu=native" cargo +nightly build --release
  cargo clean
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/procs/target/release/procs ~/Downloads/bins_"${date}"/procs_skylake
  cargo clean
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/procs/target/release/procs ~/Downloads/bins_"${date}"/procs_skylake-avx512
  # cargo clean
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/procs/target/release/procs ~/Downloads/bins_"${date}"/procs_sandybridge
  cargo clean

  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/procs/target/x86_64-unknown-linux-musl/release/procs ~/Downloads/bins_"${date}"/procs_skylake_musl
  cargo clean
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/procs/target/x86_64-unknown-linux-musl/release/procs ~/Downloads/bins_"${date}"/procs_skylake-avx512_musl
  cargo clean
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/procs/target/x86_64-unknown-linux-musl/release/procs ~/Downloads/bins_"${date}"/procs_sandybridge_musl
  cargo clean
fi

cd ~/Code/helix/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "Helix up-to-date\n\n"
else
  echo "I'm about to update Helix - stop me if you aren't ready"
  sleep 5
  git pull
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/helix/target/x86_64-unknown-linux-musl/release/hx ~/Downloads/bins_"${date}"/hx_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/helix/target/x86_64-unknown-linux-musl/release/hx ~/Downloads/bins_"${date}"/hx_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/helix/target/x86_64-unknown-linux-musl/release/hx ~/Downloads/bins_"${date}"/hx_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/helix/target/release/hx ~/Downloads/bins_"${date}"/hx_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/helix/target/release/hx ~/Downloads/bins_"${date}"/hx_skylake-avx512
  # cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/helix/target/release/hx ~/Downloads/bins_"${date}"/hx_sandybridge
  cargo clean
fi

cd ~/Code/fzf
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
    printf "fzf up-to-date\n\n"
else
  echo "I'm about to update fzf - stop me if you aren't ready"
  sleep 5
  make
  cp ~/Code/fzf/bin/fzf* ~/Downloads/bins_"${date}"/
  make clean
fi


cd ~/Code/nushell/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "Nushell up-to-date\n\n"
else
  echo "I'm about to update Nushell - stop me if you aren't ready"
  sleep 5
  git checkout -- .
  git pull
  cargo add openssl@0.10.59 --features vendored
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --features=dataframe --release
  cp ~/Code/nushell/target/x86_64-unknown-linux-musl/release/nu ~/Downloads/bins_"${date}"/nu_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --features=dataframe --release
  cp ~/Code/nushell/target/x86_64-unknown-linux-musl/release/nu ~/Downloads/bins_"${date}"/nu_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --features=dataframe --release
  cp ~/Code/nushell/target/x86_64-unknown-linux-musl/release/nu ~/Downloads/bins_"${date}"/nu_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --features=dataframe --release
  cp ~/Code/nushell/target/release/nu ~/Downloads/bins_"${date}"/nu_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --features=dataframe --release
  # cp ~/Code/nushell/target/release/nu ~/Downloads/bins_"${date}"/nu_skylake-avx512
  # cargo clean
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --features=dataframe --release
  cp ~/Code/nushell/target/release/nu ~/Downloads/bins_"${date}"/nu_sandybridge
  cargo clean
fi

cd ~/Code/starship/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "starship up-to-date\n\n"
else
  echo "I'm about to update starship - stop me if you aren't ready"
  # sleep 5
  git checkout -- .
  git pull
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/starship/target/x86_64-unknown-linux-musl/release/starship ~/Downloads/bins_"${date}"/starship_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/starship/target/x86_64-unknown-linux-musl/release/starship ~/Downloads/bins_"${date}"/starship_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/starship/target/x86_64-unknown-linux-musl/release/starship ~/Downloads/bins_"${date}"/starship_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/starship/target/release/starship ~/Downloads/bins_"${date}"/starship_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/starship/target/release/starship ~/Downloads/bins_"${date}"/starship_skylake-avx512
  # cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/starship/target/release/starship ~/Downloads/bins_"${date}"/starship_sandybridge
  cargo clean
fi

cd ~/Code/sd/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "sd up-to-date\n\n"
else
  echo "I'm about to update sd - stop me if you aren't ready"
  sleep 5
  # git checkout -- .
  git pull
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/sd/target/x86_64-unknown-linux-musl/release/sd ~/Downloads/bins_"${date}"/sd_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/sd/target/x86_64-unknown-linux-musl/release/sd ~/Downloads/bins_"${date}"/sd_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/sd/target/x86_64-unknown-linux-musl/release/sd ~/Downloads/bins_"${date}"/sd_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/sd/target/release/sd ~/Downloads/bins_"${date}"/sd_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/sd/target/release/sd ~/Downloads/bins_"${date}"/sd_skylake-avx512
  # cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/sd/target/release/sd ~/Downloads/bins_"${date}"/sd_sandybridge
  cargo clean
fi


cd ~/Code/dust/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "dust up-to-date\n\n"
else
  echo "I'm about to update dust - stop me if you aren't ready"
  sleep 5
  git pull
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/dust/target/x86_64-unknown-linux-musl/release/dust ~/Downloads/bins_"${date}"/dust_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/dust/target/x86_64-unknown-linux-musl/release/dust ~/Downloads/bins_"${date}"/dust_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/dust/target/x86_64-unknown-linux-musl/release/dust ~/Downloads/bins_"${date}"/dust_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/dust/target/release/dust ~/Downloads/bins_"${date}"/dust_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/dust/target/release/dust ~/Downloads/bins_"${date}"/dust_skylake-avx512
  # cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/dust/target/release/dust ~/Downloads/bins_"${date}"/dust_sandybridge
  cargo clean
fi

cd ~/Code/pueue/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "pueue up-to-date\n\n"
else
  echo "I'm about to update pueue - stop me if you aren't ready"
  sleep 5
  git pull
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/pueue/target/x86_64-unknown-linux-musl/release/pueue ~/Downloads/bins_"${date}"/pueue_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/pueue/target/x86_64-unknown-linux-musl/release/pueue ~/Downloads/bins_"${date}"/pueue_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/pueue/target/x86_64-unknown-linux-musl/release/pueue ~/Downloads/bins_"${date}"/pueue_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/pueue/target/release/pueue ~/Downloads/bins_"${date}"/pueue_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/pueue/target/release/pueue ~/Downloads/bins_"${date}"/pueue_skylake-avx512
  # cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/pueue/target/release/pueue ~/Downloads/bins_"${date}"/pueue_sandybridge
  cargo clean
fi

cd ~/Code/bat/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "bat up-to-date\n\n"
else
  echo "I'm about to update bat - stop me if you aren't ready"
  sleep 5
  git pull
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/bat/target/x86_64-unknown-linux-musl/release/bat ~/Downloads/bins_"${date}"/bat_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/bat/target/x86_64-unknown-linux-musl/release/bat ~/Downloads/bins_"${date}"/bat_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/bat/target/x86_64-unknown-linux-musl/release/bat ~/Downloads/bins_"${date}"/bat_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/bat/target/release/bat ~/Downloads/bins_"${date}"/bat_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/bat/target/release/bat ~/Downloads/bins_"${date}"/bat_skylake-avx512
  # cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/bat/target/release/bat ~/Downloads/bins_"${date}"/bat_sandybridge
  cargo clean
fi

cd ~/Code/rnr/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "rnr up-to-date\n\n"
else
  echo "I'm about to update rnr - stop me if you aren't ready"
  sleep 5
  git pull
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/rnr/target/x86_64-unknown-linux-musl/release/rnr ~/Downloads/bins_"${date}"/rnr_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/rnr/target/x86_64-unknown-linux-musl/release/rnr ~/Downloads/bins_"${date}"/rnr_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/rnr/target/x86_64-unknown-linux-musl/release/rnr ~/Downloads/bins_"${date}"/rnr_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/rnr/target/release/rnr ~/Downloads/bins_"${date}"/rnr_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/rnr/target/release/rnr ~/Downloads/bins_"${date}"/rnr_skylake-avx512
  # cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/rnr/target/release/rnr ~/Downloads/bins_"${date}"/rnr_sandybridge
  cargo clean
fi

cd ~/Code/zoxide/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "zoxide up-to-date\n\n"
else
  echo "I'm about to update zoxide - stop me if you aren't ready"
  sleep 5
  git pull
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/zoxide/target/x86_64-unknown-linux-musl/release/zoxide ~/Downloads/bins_"${date}"/zoxide_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/zoxide/target/x86_64-unknown-linux-musl/release/zoxide ~/Downloads/bins_"${date}"/zoxide_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/zoxide/target/x86_64-unknown-linux-musl/release/zoxide ~/Downloads/bins_"${date}"/zoxide_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/zoxide/target/release/zoxide ~/Downloads/bins_"${date}"/zoxide_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/zoxide/target/release/zoxide ~/Downloads/bins_"${date}"/zoxide_skylake-avx512
  # cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/zoxide/target/release/zoxide ~/Downloads/bins_"${date}"/zoxide_sandybridge
  cargo clean
fi

cd ~/Code/rust-parallel/
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
git fetch
REMOTE=$(git rev-parse "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
  printf "rust-parallel up-to-date\n\n"
else
  echo "I'm about to update rust-parallel - stop me if you aren't ready"
  sleep 5
  git pull
  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/rust-parallel/target/x86_64-unknown-linux-musl/release/rust-parallel ~/Downloads/bins_"${date}"/rust-parallel_skylake_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/rust-parallel/target/x86_64-unknown-linux-musl/release/rust-parallel ~/Downloads/bins_"${date}"/rust-parallel_skylake-avx512_musl
  cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --target=x86_64-unknown-linux-musl --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --target=x86_64-unknown-linux-musl --release
  cp ~/Code/rust-parallel/target/x86_64-unknown-linux-musl/release/rust-parallel ~/Downloads/bins_"${date}"/rust-parallel_sandybridge_musl
  cargo clean


  # RUSTFLAGS="-C target-cpu=skylake" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=skylake" cargo +nightly build --release
  cp ~/Code/rust-parallel/target/release/rust-parallel ~/Downloads/bins_"${date}"/rust-parallel_skylake
  cargo clean
  # RUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly-2024-02-01 build --release
  # badRUSTFLAGS="-C target-cpu=skylake-avx512" cargo +nightly build --release
  # cp ~/Code/rust-parallel/target/release/rust-parallel ~/Downloads/bins_"${date}"/rust-parallel_skylake-avx512
  # cargo clean
  # RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly-2024-02-01 build --release
  RUSTFLAGS="-C target-cpu=sandybridge" cargo +nightly build --release
  cp ~/Code/rust-parallel/target/release/rust-parallel ~/Downloads/bins_"${date}"/rust-parallel_sandybridge
  cargo clean
fi
