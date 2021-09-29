//
//  SettingsViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/26/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "AboutViewController.h"

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction) dismissAboutViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
