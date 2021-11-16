//
//  GameTimer.h
//  sm64ios
//
//  Created by Christian Kosman on 11/4/21.
//

#ifndef GameTimer_h
#define GameTimer_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GameTimer : NSObject

@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain) NSMutableArray *onGameTick;

- (id)init;
- (void)startMainLoop:(double)interval;
- (void)tick:(NSTimer *)sender;

@end

GameTimer *gameTimer;

#endif /* GameTimer_h */
