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
    self.fRunMain = true;
    return self;
}

- (void)startMainLoop:(NSInteger)gameSwapInterval {
    swapInterval = gameSwapInterval;
    self.gfxDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    self.gfxDisplayLink.preferredFramesPerSecond = 60;
    [self.gfxDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)tick:(CADisplayLink *)sender {
    self.fRunMain = true;
    
    // Runs at game's preferred FPS (30 by default, 60 with 60fps patch)
    if(frameCount % swapInterval == 0) {
        static double bank = 0;
        double frameTime = sender.duration * swapInterval;
        bank -= frameTime;
        if(bank > 0) return;
        bank = 0;
        const uint64_t startTime = mach_absolute_time();
        
        for(int i = 0; i < self.onScreenRefreshForGame.count; i++) {
            ((void (*)())[self.onScreenRefreshForGame[i] pointerValue])();
        }
        
        const uint64_t endTime = mach_absolute_time();
        const uint64_t elapsed = endTime - startTime;
        mach_timebase_info_data_t info;
        mach_timebase_info(&info);
        const double elapsedNS = (double)elapsed * (double)info.numer / (double)info.denom;
        const double elapsedS = elapsedNS/1000000000.0;
        if(elapsedS > frameTime)
            bank = frameTime + fmod(elapsedS, frameTime);
    }
    
    // Runs at 60fps
    for(int i = 0; i < self.onScreenRefresh.count; i++) {
        ((void (*)())[self.onScreenRefresh[i] pointerValue])();
    }
    frameCount++;
}

- (void)shutdown {
    [self.gfxDisplayLink invalidate];
    self.gfxDisplayLink = nil;
}

- (void)setPreferredFramesPerSecond:(NSInteger)fps {
    self.gfxDisplayLink.preferredFramesPerSecond = fps;
}

@end
