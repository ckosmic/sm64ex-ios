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
{
    NSMutableArray *m_touch_modes;
}

@property (nonatomic) NSInteger m_last_selected;

@end

#endif /* TouchControlsEnabledViewController_h */
