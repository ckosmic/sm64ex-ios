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

@interface CheatsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch* m_moon_jump_switch;
@property (weak, nonatomic) IBOutlet UISwitch* m_god_mode_switch;
@property (weak, nonatomic) IBOutlet UISwitch* m_infinite_lives_switch;
@property (weak, nonatomic) IBOutlet UISwitch* m_super_speed_switch;
@property (weak, nonatomic) IBOutlet UISwitch* m_responsive_switch;
@property (weak, nonatomic) IBOutlet UISwitch* m_exit_anywhere_switch;
@property (weak, nonatomic) IBOutlet UISwitch* m_huge_mario_switch;
@property (weak, nonatomic) IBOutlet UISwitch* m_tiny_mario_switch;

@end

#endif /* CheatsViewController_h */
