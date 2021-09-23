export CC="clang -arch x86_64 -mios-version-min=13.2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
export CXX="clang++ -arch x86_64 -mios-version-min=13.2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
export IOSINCLUDE="/Users/christiankosman/Documents/simlib/include"
export IOSLIBS="/Users/christiankosman/Documents/simlib/lib"

gmake OSX_BUILD=1 TARGET_IOS=1

if [ $? -eq 0 ]; then
    rm -rf build/sm64ios.app
    cp -a ios/. build/us_pc/
    cp -R build/us_pc build/sm64ios.app
fi
