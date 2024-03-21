#!/bin/bash

git clone https://github.com/ValveSoftware/openvr.git -b v2.2.3 /tmp/openvr/ || exit 1

CUR_USER=$(whoami)

#remove old pugixml
if [[ "$CUR_USER" == "root" ]]; then
    dnf remove -y openvr openvr-devel
else
    sudo dnf remove -y openvr openvr-devel
fi

mkdir /tmp/openvr/build

pushd /tmp/openvr/build || exit 1

cmake -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang -G "Ninja" .. || exit 1
# shellcheck disable=SC2046
ninja -j$(nproc) || exit 1

if [[ "$CUR_USER" == "root" ]]; then
    ninja install || exit 1
else
    sudo ninja install || exit 1
fi

popd || exit 1

rm -rf /tmp/openvr