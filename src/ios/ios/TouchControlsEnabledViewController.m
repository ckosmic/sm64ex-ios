//
//  TouchControlsEnabledViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/27/21.
//

#import "TouchControlsEnabledViewController.h"
#import "TouchControlsViewController.h"
#import "src/pc/configfile.h"


@implementation TouchControlsEnabledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    for (size_t i = 0; i < 3; i++) {
        if (i == configTouchMode) {
            self.lastSelected = i;
        }
    }

    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelected inSection:0]];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    [self.uiScaleSlider setValue:configTouchUiScale animated:FALSE];
    self.uiScaleLabel.text = [NSString stringWithFormat:@"%d", configTouchUiScale];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((unsigned int)indexPath.row != configTouchMode && indexPath.section == 0) {
        UITableViewCell* old_cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelected inSection:0]];
        [old_cell setAccessoryType:UITableViewCellAccessoryNone];
        
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        configTouchMode = (unsigned int)indexPath.row;
        configfile_save(configfile_name());
        
        self.lastSelected = indexPath.row;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (IBAction)UIScaleChanged:(UISlider *)sender {
    configTouchUiScale = (unsigned int)sender.value;
    configfile_save(configfile_name());
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetTouchUIScale" object:self userInfo:@{ @"scale": [NSNumber numberWithDouble:((CGFloat)configTouchUiScale)/100.0] }];
    self.uiScaleLabel.text = [NSString stringWithFormat:@"%d", configTouchUiScale];
}

@end
