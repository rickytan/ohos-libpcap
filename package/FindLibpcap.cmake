find_path(LIBPCAP_INCLUDE_DIR
    NAMES pcap.h
    HINTS "${LIBPCAP_ROOT_PATH}/include"
    NO_DEFAULT_PATH
)

find_library(LIBPCAP_LIBRARY
    NAMES pcap
    HINTS "${LIBPCAP_ROOT_PATH}/libs/${OHOS_ARCH}"
    NO_DEFAULT_PATH
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Libpcap
    REQUIRED_VARS LIBPCAP_LIBRARY LIBPCAP_INCLUDE_DIR
)

if(Libpcap_FOUND AND NOT TARGET Libpcap::Libpcap)
    add_library(Libpcap::Libpcap UNKNOWN IMPORTED)
    set_target_properties(Libpcap::Libpcap PROPERTIES
        IMPORTED_LOCATION "${LIBPCAP_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${LIBPCAP_INCLUDE_DIR}"
    )
endif()
