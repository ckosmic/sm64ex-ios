#!/bin/bash

if brew ls --versions imagemagick > /dev/null; then
    # iOS App Icons
    convert -size 1024X1024 gradient:'#0390fc'-'#00589c' "sm64ios/sm64ios/Assets.xcassets/AppIcon.appiconset/gradient.png"
    convert -interpolate Nearest -filter point -resize 720X720 "textures/segment2/segment2.05A00.rgba16.png" "sm64ios/sm64ios/Assets.xcassets/AppIcon.appiconset/head.png"
    convert "sm64ios/sm64ios/Assets.xcassets/AppIcon.appiconset/gradient.png" "sm64ios/sm64ios/Assets.xcassets/AppIcon.appiconset/head.png" -gravity center -extent 1024X1024 -background none -transparent white -layers Flatten "sm64ios/sm64ios/Assets.xcassets/AppIcon.appiconset/icon1024x1024.png"
    
    declare -a sizes=( 120x120 180x180 76x76 152x152 167x167 )
    for i in "${sizes[@]}"
    do
        convert -interpolate Nearest -filter point -resize $i "sm64ios/sm64ios/Assets.xcassets/AppIcon.appiconset/icon1024x1024.png" "sm64ios/sm64ios/Assets.xcassets/AppIcon.appiconset/icon$i.png"
    done
    
    rm "sm64ios/sm64ios/Assets.xcassets/AppIcon.appiconset/gradient.png"
    rm "sm64ios/sm64ios/Assets.xcassets/AppIcon.appiconset/head.png"
    
    
    #tvOS App Icons
    convert -size 400X240 gradient:'#0390fc'-'#00589c' "sm64ios/sm64tvos/Assets.xcassets/AppIcon.brandassets/App Icon.imagestack/Back.imagestacklayer/Content.imageset/back.png"
    convert -interpolate Nearest -filter point -resize 180X180 "textures/segment2/segment2.05A00.rgba16.png" "sm64ios/sm64tvos/Assets.xcassets/AppIcon.brandassets/App Icon.imagestack/Front.imagestacklayer/Content.imageset/head.png"
    convert -interpolate Nearest -filter point -gravity center -extent 400X240 -background none -transparent white  "sm64ios/sm64tvos/Assets.xcassets/AppIcon.brandassets/App Icon.imagestack/Front.imagestacklayer/Content.imageset/head.png" "sm64ios/sm64tvos/Assets.xcassets/AppIcon.brandassets/App Icon.imagestack/Front.imagestacklayer/Content.imageset/front.png"
    
    rm "sm64ios/sm64tvos/Assets.xcassets/AppIcon.brandassets/App Icon.imagestack/Front.imagestacklayer/Content.imageset/head.png"
fi
