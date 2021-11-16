//
//  SettingsViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/30/21.
//

#import "TVOSSettingsViewController.h"
#import "src/pc/configfile.h"

@implementation TVOSSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.hudSwitch setOn:configHUD];
    self.hudSwitch.callback = ^() {
        [self hudChanged];
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)hudChanged {
    configHUD = [self.hudSwitch isOn];
    configfile_save(configfile_name());
}

@end
