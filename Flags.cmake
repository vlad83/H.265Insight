IF(USE_CLANG)
    # C++ compiler flags
    SET(CMAKE_CXX_FLAGS "-std=c++14 -Wall -Wextra -Wno-parentheses -pedantic -fno-exceptions -Wno-unused-local-typedefs -fwrapv")
    SET(CMAKE_CXX_FLAGS_DEBUG "-g -O0 -DPTR_CHECK -DBDRY_CHECK -DNUMERIC_CHECK" )
    SET(CMAKE_CXX_FLAGS_RELEASE "-O2 -mtune=native -DNO_DEBUG -DNDEBUG -fPIC -rdynamic -Wno-unused-parameter" )
    # C compiler flags
    SET(CMAKE_C_FLAGS "-std=c99 -Wall -Wextra -fwrapv")
    SET(CMAKE_C_FLAGS_DEBUG ${CMAKE_CXX_FLAGS_DEBUG})
    SET(CMAKE_C_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE})
    # additional flags
    SET(CMAKE_EXE_LINKER_FLAGS "-lstdc++ -lpthread -lm")
ELSE(USE_CLANG)
    # C++ compiler flags
    SET(CMAKE_CXX_FLAGS "-std=c++14 -pipe -fstack-protector-all -Wall -Wextra -Wno-parentheses -pedantic -Wno-unused-local-typedefs -fdiagnostics-color=always -fno-exceptions -fwrapv" )
    SET(CMAKE_CXX_FLAGS_DEBUG "-g -O0 -fno-omit-frame-pointer -DPTR_CHECK -DBDRY_CHECK -DNUMERIC_CHECK" )
    SET(CMAKE_CXX_FLAGS_RELEASE "-O2 -mtune=native -DNO_DEBUG -DNDEBUG -fPIC -rdynamic -Wno-unused-parameter" )
    # C compiler flags
    SET(CMAKE_C_FLAGS "-std=c99 -Wall -Wextra -fwrapv")
    SET(CMAKE_C_FLAGS_DEBUG ${CMAKE_CXX_FLAGS_DEBUG})
    SET(CMAKE_C_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE})
    # additional flags
    SET(CMAKE_EXE_LINKER_FLAGS "-lstdc++ -lpthread -lm")
ENDIF(USE_CLANG)

OPTION(ENABLE_ASAN "Enable Address Sanitizer" OFF)
OPTION(ENABLE_UBSAN "Enable Undefined Behavior Sanitizer" OFF)
OPTION(ENABLE_DBGSYMS "Enable debug symbols in RELEASE build" OFF)
OPTION(ENABLE_GPROF "Enable GNU Pofiler" OFF)

IF(ENABLE_ASAN)
    SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=address")
ENDIF(ENABLE_ASAN)

IF(ENABLE_UBSAN)
    SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=undefined")
ENDIF(ENABLE_UBSAN)

IF(ABORT_ON_SEI_HASH_MISMATCH)
    SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -DABORT_ON_SEI_HASH_MISMATCH")
    SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DABORT_ON_SEI_HASH_MISMATCH")
ENDIF(ABORT_ON_SEI_HASH_MISMATCH)

IF(BDRY_CHECK)
    SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -DBDRY_CHECK")
    SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DBDRY_CHECK")
ENDIF(BDRY_CHECK)

IF(ENABLE_DBGSYMS)
    SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -g")
ENDIF(ENABLE_DBGSYMS)

IF(ENABLE_GPROF)
    SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -pg")
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pg")
ENDIF(ENABLE_GPROF)

SET(CMAKE_EXPORT_COMPILE_COMMANDS "ON")
