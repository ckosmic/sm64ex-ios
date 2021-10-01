//
//  SettingsViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/30/21.
//

#import "SettingsViewController.h"
#import "../pc/configfile.h"

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.m_haptics_switch setOn:configHaptics];
    [self.m_hud_switch setOn:configHUD];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (IBAction)HapticsChanged:(id)sender
{
    configHaptics = [self.m_haptics_switch isOn];
    configfile_save(configfile_name());
}

- (IBAction)HUDChanged:(id)sender
{
    configHUD = [self.m_hud_switch isOn];
    configfile_save(configfile_name());
}

@end
