#!/bin/sh
export OHOS_NDK_HOME=/Applications/DevEco-Studio.app/Contents/sdk/default/openharmony

patch_file="${PWD}/patchs/libpcap.patch"

pushd "libpcap"
git apply "${patch_file}"
popd

build_architecture() {
    local arch=$1
    local script_path="${PWD}/scripts/${arch}.sh"
    local output_dir="${PWD}/prelude/${arch}"
    local build_dir="${PWD}/build/${arch}"

    echo "Start to build ${arch}"
    if source "${script_path}"; then
        mkdir -p "${build_dir}"
        cmake -S libpcap -B "${build_dir}" \
            -DCMAKE_TOOLCHAIN_FILE="${PWD}/scripts/ohos.toolchain.cmake" \
            -DCMAKE_INSTALL_PREFIX="${output_dir}" \
            -DCMAKE_BUILD_TYPE=Release \
            -DPCAP_TYPE=linux \
            -DBUILD_WITH_LIBNL=OFF \
            -DBUILD_SHARED_LIBS=ON \
            -DENABLE_REMOTE=OFF && \
        cmake --build "${build_dir}" && \
        cmake --install "${build_dir}"
    else
        echo "Failed to source script for ${arch}"
        exit 1
    fi
}

build_architecture "arm64-v8a"

build_architecture "armeabi-v7a"

build_architecture "x86_64"

pushd "libpcap"
git apply --reverse "${patch_file}"
popd
