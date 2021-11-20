//
//  RemoteInputController.m
//  sm64ios
//
//  Created by Christian Kosman on 11/11/21.
//

#import "RemoteInputController.h"

@implementation RemoteInputController {
    UITapGestureRecognizer *menuButtonRecognizer;
    UITapGestureRecognizer *playPauseButtonRecognizer;
}

- (id)initWithTarget:(UIViewController *)viewController {
    self = [super init];
    
    self.onMenuButtonPressed = [[NSMutableArray array] retain];
    self.onPlayPauseButtonPressed = [[NSMutableArray array] retain];
    
    menuButtonRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMenuButtonPress:)];
    menuButtonRecognizer.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypeMenu]];
    [viewController.view addGestureRecognizer:menuButtonRecognizer];
    
    playPauseButtonRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePlayPauseButtonPress:)];
    playPauseButtonRecognizer.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypePlayPause]];
    [viewController.view addGestureRecognizer:playPauseButtonRecognizer];
    
    return self;
}

- (void)handleMenuButtonPress:(UITapGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateEnded) {
        for(int i = 0; i < self.onMenuButtonPressed.count; i++) {
            ((void (*)())[self.onMenuButtonPressed[i] pointerValue])();
        }
    }
}

- (void)handlePlayPauseButtonPress:(UITapGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateEnded) {
        for(int i = 0; i < self.onPlayPauseButtonPressed.count; i++) {
            ((void (*)())[self.onPlayPauseButtonPressed[i] pointerValue])();
        }
    }
}

@end
