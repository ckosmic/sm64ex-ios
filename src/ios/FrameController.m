//
//  FrameController.m
//  sm64ios
//
//  Created by Christian Kosman on 11/2/21.
//

#import "FrameController.h"

@implementation FrameController {
    int frameCount;
    int swapInterval;
}

- (id)init {
    self = [super init];
    self.onScreenRefresh = [NSMutableArray array];
    self.onScreenRefreshForGame = [NSMutableArray array];
    frameCount = 0;
    return self;
}

- (void)startMainLoop:(NSInteger)gameSwapInterval {
    swapInterval = gameSwapInterval;
    self.gfxDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    self.gfxDisplayLink.preferredFramesPerSecond = 30;
    [self.gfxDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)tick:(CADisplayLink *)sender {
    //if(frameCount % swapInterval == 0) {
        for(int i = 0; i < self.onScreenRefreshForGame.count; i++) {
            ((void (*)())[self.onScreenRefreshForGame[i] pointerValue])();
        }
    //}
    //for(int i = 0; i < self.onScreenRefresh.count; i++) {
    //    ((void (*)())[self.onScreenRefresh[i] pointerValue])();
    //}
    //frameCount++;
}

- (void)shutdown {
    [self.gfxDisplayLink invalidate];
    self.gfxDisplayLink = nil;
}

- (void)setPreferredFramesPerSecond:(NSInteger)fps {
    self.gfxDisplayLink.preferredFramesPerSecond = fps;
}

@end
