//
//  SettingsViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/30/21.
//

#import "SettingsViewController.h"
#import "src/pc/configfile.h"

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.hapticsSwitch setOn:configHaptics];
    [self.hudSwitch setOn:configHUD];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (IBAction)HapticsChanged:(id)sender {
    configHaptics = [self.hapticsSwitch isOn];
    configfile_save(configfile_name());
}

- (IBAction)HUDChanged:(id)sender {
    configHUD = [self.hudSwitch isOn];
    configfile_save(configfile_name());
}

@end
