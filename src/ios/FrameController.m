//
//  FrameController.m
//  sm64ios
//
//  Created by Christian Kosman on 11/2/21.
//

#import "FrameController.h"

@implementation FrameController

- (id)init {
    self = [super init];
    self.onScreenRefresh = [[NSMutableArray array] retain];
    return self;
}

- (void)startMainLoop {
    self.gfxDisplayLink = [[CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)] retain];
    self.gfxDisplayLink.preferredFramesPerSecond = 60;
    [self.gfxDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)tick:(CADisplayLink *)sender {
    for(int i = 0; i < self.onScreenRefresh.count; i++) {
        ((void (*)())[self.onScreenRefresh[i] pointerValue])();
    }
}

- (void)shutdown {
    [self.gfxDisplayLink invalidate];
    self.gfxDisplayLink = nil;
}

@end
