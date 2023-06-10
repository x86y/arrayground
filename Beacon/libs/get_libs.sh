cd cbqn

rm -rf build/obj2
SDKROOT=`xcrun --sdk iphonesimulator --show-sdk-path` BQN ./build/src/build.bqn shared o3 FFI=0
ar rcs simbqn.a build/obj2/cbqn-*/*.o

rm -rf build/obj2
SDKROOT=`xcrun --sdk iphoneos --show-sdk-path` BQN ./build/src/build.bqn shared o3 FFI=0
ar rcs iosbqn.a build/obj2/cbqn-*/*.o

lipo -create *bqn.a -output libcbqn.a
cd -
