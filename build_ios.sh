export CC="clang -arch arm64 -mios-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
export CXX="clang++ -arch arm64 -mios-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
export IOSINCLUDE="../ioslib/include"
export IOSLIBS="../ioslib/lib"
export CODE_SIGN_IDENTITY="Apple Development"
export CODE_SIGN_ENTITLEMENTS="sm64ios.entitlements"

gmake ios -j4 TARGET_IOS=1

cp -R "build/us_pc/." "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/"
