//
//  TouchControlsEnabledViewController.h
//  sm64ios
//
//  Created by Christian Kosman on 9/27/21.
//

#ifndef TouchControlsEnabledViewController_h
#define TouchControlsEnabledViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TouchControlsEnabledViewController : UITableViewController

@property (nonatomic) NSInteger lastSelected;

@property (weak, nonatomic) IBOutlet UISlider* uiScaleSlider;
@property (weak, nonatomic) IBOutlet UILabel* uiScaleLabel;


@end

#endif /* TouchControlsEnabledViewController_h */
