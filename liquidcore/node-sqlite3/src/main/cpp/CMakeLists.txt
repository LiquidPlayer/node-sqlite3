cmake_minimum_required(VERSION 3.4.1)

add_library(
        node-sqlite3.node
        SHARED
        sqlite3_shim.cpp
        ${PROJECT_SOURCE_DIR}/../../../../../src/node_sqlite3.cc
        ${PROJECT_SOURCE_DIR}/../../../../../src/database.cc
        ${PROJECT_SOURCE_DIR}/../../../../../src/statement.cc
)

include_directories(
        ${PROJECT_SOURCE_DIR}/../../../build/liquidcore-addon/include/node
        ${PROJECT_SOURCE_DIR}/../../../build/liquidcore-addon/include/v8
        ${PROJECT_SOURCE_DIR}/../../../build/liquidcore-addon/include/uv
        ${PROJECT_SOURCE_DIR}/../../../build/liquidcore-addon/include/cares
        ${PROJECT_SOURCE_DIR}/../../../build/liquidcore-addon/include
        ${PROJECT_SOURCE_DIR}/../../../../../src
        ${PROJECT_SOURCE_DIR}
        ${PROJECT_SOURCE_DIR}/../../../../../node_modules/nan
)

unset(EXTRA_CXX_FLAGS)
list(APPEND EXTRA_CXX_FLAGS
        -Wno-deprecated-declarations
        -DNODE_WANT_INTERNALS=1
)
string (REPLACE ";" " " CPP_FLAGS_STR "${EXTRA_CXX_FLAGS}")
SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${CPP_FLAGS_STR}" )


find_library(
        log-lib
        log)

add_library(
        node-lib
        SHARED
        IMPORTED
)
add_library(
        liquidcore-lib
        SHARED
        IMPORTED
)
set_target_properties(
        node-lib
        PROPERTIES IMPORTED_LOCATION
        ${PROJECT_SOURCE_DIR}/../../../build/liquidcore-addon/jni/${ANDROID_ABI}/libnode.so
)
set_target_properties(
        liquidcore-lib
        PROPERTIES IMPORTED_LOCATION
        ${PROJECT_SOURCE_DIR}/../../../build/liquidcore-addon/jni/${ANDROID_ABI}/libliquidcore.so
)
target_link_libraries( # Specifies the target library.
        node-sqlite3.node
        node-lib
        liquidcore-lib
        ${log-lib})
