//
//  MenuViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/26/21.
//

#import "MenuViewController.h"


@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (IBAction) dismissAboutViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
