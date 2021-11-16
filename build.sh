codesign --remove-signature "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}"

case ${PLATFORM_NAME} in
    iphoneos)
        export CC="clang -arch arm64 --target=arm64-apple-ios -mios-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_IOS"
        export CXX="clang++ -arch arm64 -mios-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_IOS"
        export TARGET_OS_IOS=1
        rsync -aP --exclude="Info.plist" "sm64ios/sm64ios/" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}"
        ;;
    iphonesimulator)
        export CC="clang -arch x86_64 -mios-simulator-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_IOS"
        export CXX="clang++ -arch x86_64 -mios-simulator-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_IOS"
        export TARGET_OS_IOS=1
        rsync -aP --exclude="Info.plist" "sm64ios/sm64ios/" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}"
        ;;
    appletvos)
        export CC="clang -arch arm64 -mtvos-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_TV"
        export CXX="clang++ -arch arm64 -mtvos-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_TV"
        export TARGET_OS_TV=1
        rsync -aP --exclude="Info.plist" "sm64ios/sm64tvos/" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}"
        ;;
    appletvsimulator)
        export CC="clang -arch x86_64 -mtvos-simulator-version-min=13.2 -fobjc-weak -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/SDKs/AppleTVSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_TV"
        export CXX="clang++ -arch x86_64 -mtvos-simulator-version-min=13.2 -fobjc-weak -std=c++11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/SDKs/AppleTVSimulator.sdk -DUSE_GLES -DAAPI_SDL2 -DWAPI_SDL2 -DTARGET_OS_TV"
        export TARGET_OS_TV=1
        rsync -aP --exclude="Info.plist" "sm64ios/sm64tvos/" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}"
        ;;
esac

export IOSINCLUDE="${SDL2_INCLUDE_DIR}/"
export IOSLIBS="${BUILT_PRODUCTS_DIR}/"

gmake -j4 TARGET_IOS=1

cp -R "build/us_pc/." "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/"
rsync -aP --exclude="Info.plist" "ios/" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}"
