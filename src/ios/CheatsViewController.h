//
//  CheatsViewController.h
//  sm64ios
//
//  Created by Christian Kosman on 9/29/21.
//

#ifndef CheatsViewController_h
#define CheatsViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#if TARGET_OS_TV
#import "src/ios/tvos/TVOSSwitch.h"
#endif

@interface CheatsViewController : UITableViewController

#if TARGET_OS_IOS
@property (weak, nonatomic) IBOutlet UISwitch* enableCheatsSwitch;

@property (weak, nonatomic) IBOutlet UISwitch* moonJumpSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* godModeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* infiniteLivesSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* superSpeedSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* responsiveSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* exitAnywhereSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* hugeMarioSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* tinyMarioSwitch;
#elif TARGET_OS_TV
@property (weak, nonatomic) IBOutlet TVOSSwitch* enableCheatsSwitch;

@property (weak, nonatomic) IBOutlet TVOSSwitch* moonJumpSwitch;
@property (weak, nonatomic) IBOutlet TVOSSwitch* godModeSwitch;
@property (weak, nonatomic) IBOutlet TVOSSwitch* infiniteLivesSwitch;
@property (weak, nonatomic) IBOutlet TVOSSwitch* superSpeedSwitch;
@property (weak, nonatomic) IBOutlet TVOSSwitch* responsiveSwitch;
@property (weak, nonatomic) IBOutlet TVOSSwitch* exitAnywhereSwitch;
@property (weak, nonatomic) IBOutlet TVOSSwitch* hugeMarioSwitch;
@property (weak, nonatomic) IBOutlet TVOSSwitch* tinyMarioSwitch;
#endif

@end

#endif /* CheatsViewController_h */
