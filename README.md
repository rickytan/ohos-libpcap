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

## Installation

### From OHPM

```sh
ohpm install @rickytan/libpcap --save-dev
```

### From local HAR

```sh
ohpm install ./libpcap.har --save-dev
```

## Usage in CMake

```cmake
find_package(Libpcap REQUIRED HINTS "${OHPM_PACKAGE_PATH}/package")
target_link_libraries(your_target Libpcap::Libpcap)
```

Set `LIBPCAP_ROOT_PATH` to the installed package root and `OHOS_ARCH` to the target architecture.

## Security Considerations

- **Permissions**: libpcap requires the `ohos.permission.INTERNET` privilege and raw socket access (`CAP_NET_RAW`) to capture network packets. Apps using this library must declare these permissions in their `module.json5`.
- **Sensitive data**: Packet capture inherently exposes network traffic. Do not log or persist captured packets containing credentials, tokens, or personal information without proper encryption and access control.
- **Privilege minimisation**: Open the capture handle with the minimum required filter and promiscuous mode disabled (`pcap_set_promisc(pcap, 0)`) unless explicitly needed.
- **Snaplen**: Use the smallest practical snap length (`pcap_set_snaplen`) to limit exposure of packet payloads beyond what your analysis requires.
- **Upstream source**: This package is built from the official [libpcap repository](https://github.com/the-tcpdump-group/libpcap). Verify the submodule commit against upstream tags before building. Report upstream vulnerabilities to the tcpdump group directly.

## License

This project's build scripts and packaging are MIT licensed. The libpcap library itself is BSD-3-Clause licensed — see [libpcap/LICENSE](https://github.com/the-tcpdump-group/libpcap/blob/master/LICENSE).
