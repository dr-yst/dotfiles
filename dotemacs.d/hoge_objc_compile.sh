clang -cc1 -x c++-header ./hoge_objc.h  -emit-pch -o hoge_objc.pch -I/opt/local/libexec/llvm-3.4/include  -D_DEBUG -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -O3 -g -fno-common

