# ohos-libpcap

HarmonyOS (OHOS) cross-compilation of [libpcap](https://github.com/the-tcpdump-group/libpcap).

## Prerequisites

- OHOS NDK (DevEco-Studio SDK)
- `flex` and `bison` installed on host (`brew install flex bison`)

## Build

```sh
bash scripts/build.sh
```

This will cross-compile libpcap for arm64-v8a, armeabi-v7a, and x86_64. Build outputs go to `prelude/<arch>/`.

## Package

```sh
bash scripts/har.sh
```

Generates `libpcap.har` for OHPM distribution.

## Usage in CMake

```cmake
find_package(Libpcap REQUIRED HINTS "${OHPM_PACKAGE_PATH}/package")
target_link_libraries(your_target Libpcap::Libpcap)
```

Set `LIBPCAP_ROOT_PATH` to the installed package root and `OHOS_ARCH` to the target architecture.
