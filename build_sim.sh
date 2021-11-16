export CC="clang -arch x86_64 -mios-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_IOS"
export CXX="clang++ -arch x86_64 -mios-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_IOS"
export IOSINCLUDE="../simlib/include"
export IOSLIBS="../simlib/lib"

gmake sim -j4 TARGET_IOS=1
