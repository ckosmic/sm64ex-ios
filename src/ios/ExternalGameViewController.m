//
//  ExternalGameViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 10/19/21.
//

#import "ExternalGameViewController.h"


@implementation ExternalGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.autoresizesSubviews = TRUE;
}

- (void)setDebugText:(NSString *)msg {
    [self.m_debug_label setText:msg];
}

@end
