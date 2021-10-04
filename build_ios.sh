export CC="clang -arch arm64 -mios-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
export CXX="clang++ -arch arm64 -mios-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
export IOSINCLUDE="../ioslib/include"
export IOSLIBS="../ioslib/lib"

gmake -j4 TARGET_IOS=1 EXTERNAL_DATA=1

if [ $? -eq 0 ]; then
    rm -rf build/sm64ios.app
    cp -a ios/. build/us_pc/
    cp -R build/us_pc build/sm64ios.app
    codesign -f -s "Apple Development" --entitlements sm64ios.entitlements build/sm64ios.app
    rm -rf build/Payload
    rm -rf build/sm64ios.ipa
    mkdir build/Payload
    cp -r build/sm64ios.app build/Payload
    cd build
    zip -r -q sm64ios.ipa Payload
    rm -rf Payload
    rm -rf sm64ios.app
    cd ..
fi
