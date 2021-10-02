//
//  MenuViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/26/21.
//

#import "MenuViewController.h"
#import "native_ui_controller.h"


@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    paused_by_menu = true;
    NSString *versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.m_version_label setText:versionNumber];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (IBAction)dismissAboutViewController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender
{
    paused_by_menu = false;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
