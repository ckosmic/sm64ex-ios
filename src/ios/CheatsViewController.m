//
//  CheatsViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/29/21.
//

#import "CheatsViewController.h"
#import "src/pc/cheats.h"

@implementation CheatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.enableCheatsSwitch setOn:Cheats.EnableCheats];
    [self.moonJumpSwitch setOn:Cheats.MoonJump];
    [self.godModeSwitch setOn:Cheats.GodMode];
    [self.infiniteLivesSwitch setOn:Cheats.InfiniteLives];
    [self.superSpeedSwitch setOn:Cheats.SuperSpeed];
    [self.responsiveSwitch setOn:Cheats.Responsive];
    [self.exitAnywhereSwitch setOn:Cheats.ExitAnywhere];
    [self.hugeMarioSwitch setOn:Cheats.HugeMario];
    [self.tinyMarioSwitch setOn:Cheats.TinyMario];
    
#if TARGET_OS_TV
    self.enableCheatsSwitch.callback = ^() {
        [self EnableCheatsChanged:nil];
    };
    self.moonJumpSwitch.callback = ^() {
        [self MoonJumpChanged:nil];
    };
    self.godModeSwitch.callback = ^() {
        [self GodModeChanged:nil];
    };
    self.infiniteLivesSwitch.callback = ^() {
        [self InfiniteLivesChanged:nil];
    };
    self.superSpeedSwitch.callback = ^() {
        [self SuperSpeedChanged:nil];
    };
    self.responsiveSwitch.callback = ^() {
        [self ResponsiveChanged:nil];
    };
    self.exitAnywhereSwitch.callback = ^() {
        [self ExitAnywhereChanged:nil];
    };
    self.hugeMarioSwitch.callback = ^() {
        [self HugeMarioChanged:nil];
    };
    self.tinyMarioSwitch.callback = ^() {
        [self TinyMarioChanged:nil];
    };
#endif
}

- (IBAction)EnableCheatsChanged:(id)sender {
    Cheats.EnableCheats = [self.enableCheatsSwitch isOn];
}

- (IBAction)MoonJumpChanged:(id)sender {
    Cheats.MoonJump = [self.moonJumpSwitch isOn];
}

- (IBAction)GodModeChanged:(id)sender {
    Cheats.GodMode = [self.godModeSwitch isOn];
}

- (IBAction)InfiniteLivesChanged:(id)sender {
    Cheats.InfiniteLives = [self.infiniteLivesSwitch isOn];
}

- (IBAction)SuperSpeedChanged:(id)sender {
    Cheats.SuperSpeed = [self.superSpeedSwitch isOn];
}

- (IBAction)ResponsiveChanged:(id)sender {
    Cheats.Responsive = [self.responsiveSwitch isOn];
}

- (IBAction)ExitAnywhereChanged:(id)sender {
    Cheats.ExitAnywhere = [self.exitAnywhereSwitch isOn];
}

- (IBAction)HugeMarioChanged:(id)sender {
    Cheats.HugeMario = [self.hugeMarioSwitch isOn];
}

- (IBAction)TinyMarioChanged:(id)sender {
    Cheats.TinyMario = [self.tinyMarioSwitch isOn];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
