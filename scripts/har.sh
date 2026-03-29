#!/bin/sh

rm -rf ./package/include/
rm -rf ./package/libs/

# Copy metadata files
cp README.md CHANGELOG.md LICENSE ./package/

# Headers (architecture-independent, take from one arch only)
cp -r "./prelude/arm64-v8a/include" "./package/"

# Per-architecture libraries
for arch in arm64-v8a armeabi-v7a x86_64; do
    mkdir -p "./package/libs/${arch}"
    cp "./prelude/${arch}/lib/libpcap.a" "./package/libs/${arch}/"
    cp "./prelude/${arch}/lib/libpcap.so" "./package/libs/${arch}/"
done

tar -zcvf libpcap.har package/
