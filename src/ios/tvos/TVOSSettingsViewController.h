//
//  TVOSSettingsViewController.h
//  sm64ios
//
//  Created by Christian Kosman on 9/30/21.
//

#ifndef TVOSSettingsViewController_h
#define TVOSSettingsViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TVOSSwitch.h"

@interface TVOSSettingsViewController : UITableViewController

@property (nonatomic) IBOutlet TVOSSwitch* hudSwitch;

@end

#endif /* TVOSSettingsViewController_h */
