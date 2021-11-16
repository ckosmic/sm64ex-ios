//
//  RemoteInputController.m
//  sm64ios
//
//  Created by Christian Kosman on 11/11/21.
//

#import "RemoteInputController.h"

@implementation RemoteInputController {
    UITapGestureRecognizer *tapRecognizer;
}

- (id)initWithTarget:(UIViewController *)viewController {
    self = [super init];
    
    self.onMenuButtonPressed = [[NSMutableArray array] retain];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypePlayPause]];
    [viewController.view addGestureRecognizer:tapRecognizer];
    
    return self;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateEnded) {
        for(int i = 0; i < self.onMenuButtonPressed.count; i++) {
            ((void (*)())[self.onMenuButtonPressed[i] pointerValue])();
        }
    }
}

@end
