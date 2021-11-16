export CC="clang -arch arm64 -mtvos-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_TV"
export CXX="clang++ -arch arm64 -mtvos-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_TV"
export IOSINCLUDE="../tvoslib/include"
export IOSLIBS="../tvoslib/lib"
export CODE_SIGN_IDENTITY="Apple Development"
export CODE_SIGN_ENTITLEMENTS="sm64ios.entitlements"

gmake ios -j4 TARGET_IOS=1 TARGET_OS_TV=1
