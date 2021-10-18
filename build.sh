case ${PLATFORM_NAME} in
    iphoneos)
        export CC="clang -arch arm64 -mios-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
        export CXX="clang++ -arch arm64 -mios-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
        export IOSINCLUDE="${SDL2_INCLUDE_DIR}"
        export IOSLIBS="${BUILT_PRODUCTS_DIR}/"
        ;;
    iphonesimulator)
        export CC="clang -arch x86_64 -mios-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
        export CXX="clang++ -arch x86_64 -mios-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2"
        export IOSINCLUDE="${SDL2_INCLUDE_DIR}"
        export IOSLIBS="${BUILT_PRODUCTS_DIR}/"
        ;;
esac

gmake sim -j4 TARGET_IOS=1

cp -R "build/us_pc/." "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/"
