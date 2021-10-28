#!/bin/bash

if brew ls --versions imagemagick > /dev/null; then
    convert -size 1024X1024 gradient:'#0390fc'-'#00589c' "ios/Assets.xcassets/AppIcon.appiconset/gradient.png"
    convert -interpolate Nearest -filter point -resize 720X720 "textures/segment2/segment2.05A00.rgba16.png" "ios/Assets.xcassets/AppIcon.appiconset/head.png"
    convert "ios/Assets.xcassets/AppIcon.appiconset/gradient.png" "ios/Assets.xcassets/AppIcon.appiconset/head.png" -gravity center -extent 1024X1024 -background none -transparent white -layers Flatten "ios/Assets.xcassets/AppIcon.appiconset/icon1024x1024.png"
    
    declare -a sizes=( 120x120 180x180 76x76 152x152 167x167 )
    for i in "${sizes[@]}"
    do
        convert -interpolate Nearest -filter point -resize $i "ios/Assets.xcassets/AppIcon.appiconset/icon1024x1024.png" "ios/Assets.xcassets/AppIcon.appiconset/icon$i.png"
    done
    
    rm "ios/Assets.xcassets/AppIcon.appiconset/gradient.png"
    rm "ios/Assets.xcassets/AppIcon.appiconset/head.png"
fi
