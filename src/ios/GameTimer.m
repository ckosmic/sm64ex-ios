//
//  GameTimer.m
//  sm64ios
//
//  Created by Christian Kosman on 11/4/21.
//

#import "GameTimer.h"

@implementation GameTimer

- (id)init {
    self = [super init];
    self.onGameTick = [[NSMutableArray array] retain];
    return self;
}

- (void)startMainLoop:(double)interval {
    self.timer = [[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(tick:) userInfo:nil repeats:YES] retain];
}

- (void)tick:(NSTimer *)sender {
    for(int i = 0; i < self.onGameTick.count; i++) {
        ((void (*)())[self.onGameTick[i] pointerValue])();
    }
}

- (void)shutdown {
    [self.timer invalidate];
    self.timer = nil;
}

@end
