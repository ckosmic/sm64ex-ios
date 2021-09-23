export CC="clang -arch arm64 -mios-version-min=13.2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
export CXX="clang++ -arch arm64 -mios-version-min=13.2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
export IOSINCLUDE="/Users/christiankosman/Documents/ioslib/include"
export IOSLIBS="/Users/christiankosman/Documents/ioslib/lib"

gmake OSX_BUILD=1 TARGET_IOS=1

if [ $? -eq 0 ]; then
    rm -rf build/sm64ios.app
    cp -a ios/. build/us_pc/
    cp -R build/us_pc build/sm64ios.app
    codesign -f -s "Apple Development" --entitlements sm64ios.entitlements build/sm64ios.app
    rm -rf build/Payload
    rm build/sm64ios.ipa
    mkdir build/Payload
    cp -r build/sm64ios.app build/Payload
    cd build
    zip -r -q sm64ios.ipa Payload
    cd ..
fi