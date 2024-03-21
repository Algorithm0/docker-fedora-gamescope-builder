#!/bin/bash

git clone https://github.com/AOMediaCodec/libavif.git -b v1.0.4 /tmp/libavif/ || exit 1

CUR_USER=$(whoami)

#remove old pugixml
if [[ "$CUR_USER" == "root" ]]; then
    dnf remove -y libavif libavif-devel
else
    sudo dnf remove -y libavif libavif-devel
fi

mkdir /tmp/libavif/build

pushd /tmp/libavif/build || exit 1

cmake -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang -G "Ninja" .. || exit 1
# shellcheck disable=SC2046
ninja -j$(nproc) || exit 1

if [[ "$CUR_USER" == "root" ]]; then
    ninja install || exit 1
else
    sudo ninja install || exit 1
fi

popd || exit 1

rm -rf /tmp/libavif