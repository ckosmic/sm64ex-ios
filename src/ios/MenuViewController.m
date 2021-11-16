//
//  MenuViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/26/21.
//

#import "MenuViewController.h"
#import "native_ui_controller.h"


@implementation MenuViewController
#if TARGET_OS_TV
{
    UITapGestureRecognizer *tapRecognizer;
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    paused_by_menu = true;
    NSString *versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.versionLabel setText:versionNumber];
    
#if TARGET_OS_TV
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypeMenu]];
    [self.view addGestureRecognizer:tapRecognizer];
#endif
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (IBAction)dismissAboutViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#if !TARGET_OS_TV
- (IBAction)doneButtonPressed:(id)sender {
    paused_by_menu = false;
    [self dismissViewControllerAnimated:YES completion:nil];
}
#else
- (void)backButtonPressed {
    paused_by_menu = false;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateEnded) {
        [self backButtonPressed];
    }
}
#endif

@end
