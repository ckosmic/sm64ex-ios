//
//  CheatsViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/29/21.
//

#import "CheatsViewController.h"
#import "../pc/cheats.h"

@implementation CheatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.m_enable_cheats_switch setOn:Cheats.EnableCheats];
    [self.m_moon_jump_switch setOn:Cheats.MoonJump];
    [self.m_god_mode_switch setOn:Cheats.GodMode];
    [self.m_infinite_lives_switch setOn:Cheats.InfiniteLives];
    [self.m_super_speed_switch setOn:Cheats.SuperSpeed];
    [self.m_responsive_switch setOn:Cheats.Responsive];
    [self.m_exit_anywhere_switch setOn:Cheats.ExitAnywhere];
    [self.m_huge_mario_switch setOn:Cheats.HugeMario];
    [self.m_tiny_mario_switch setOn:Cheats.TinyMario];
}

- (IBAction)EnableCheatsChanged:(id)sender
{
    Cheats.EnableCheats = [self.m_enable_cheats_switch isOn];
}

- (IBAction)MoonJumpChanged:(id)sender
{
    Cheats.MoonJump = [self.m_moon_jump_switch isOn];
}

- (IBAction)GodModeChanged:(id)sender
{
    Cheats.GodMode = [self.m_god_mode_switch isOn];
}

- (IBAction)InfiniteLivesChanged:(id)sender
{
    Cheats.InfiniteLives = [self.m_infinite_lives_switch isOn];
}

- (IBAction)SuperSpeedChanged:(id)sender
{
    Cheats.SuperSpeed = [self.m_super_speed_switch isOn];
}

- (IBAction)ResponsiveChanged:(id)sender
{
    Cheats.Responsive = [self.m_responsive_switch isOn];
}

- (IBAction)ExitAnywhereChanged:(id)sender
{
    Cheats.ExitAnywhere = [self.m_exit_anywhere_switch isOn];
}

- (IBAction)HugeMarioChanged:(id)sender
{
    Cheats.HugeMario = [self.m_huge_mario_switch isOn];
}

- (IBAction)TinyMarioChanged:(id)sender
{
    Cheats.TinyMario = [self.m_tiny_mario_switch isOn];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
