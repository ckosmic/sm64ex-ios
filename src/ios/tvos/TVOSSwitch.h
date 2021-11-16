//
//  TVOSSwitch.h
//  sm64ios
//
//  Created by Christian Kosman on 11/12/21.
//
//  From DOLATVSwitchCell from DolphiniOS
//  https://github.com/OatmealDome/dolphin/blob/ios-jb/Source/iOS/DolphiniOS/DolphinATV/UI/Util/DOLATVSwitchCell.h
//  Added/removed/renamed various methods/properties for sm64ios
//

#ifndef TVOSSwitch_h
#define TVOSSwitch_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TVOSTableViewCell.h"

typedef void(^ChangedAction)(void);

@interface TVOSSwitch : TVOSTableViewCell

@property(nonatomic) UILabel *switchLabel;
@property(nonatomic, getter=isOn, setter=setOn:) BOOL on;
@property(nonatomic, copy) ChangedAction callback;

- (void)setOn:(BOOL)on;

@end

#endif /* TVOSSwitch_h */
