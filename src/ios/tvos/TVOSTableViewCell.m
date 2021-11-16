//
//  TVOSTableViewCell.m
//  sm64ios
//
//  Created by Christian Kosman on 11/13/21.
//

#import "TVOSTableViewCell.h"

@implementation TVOSTableViewCell

// Bug or I'm just stupid? Labels stay white when selected so we have to color it ourselves.
- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    [super didUpdateFocusInContext: context withAnimationCoordinator:coordinator];
    
    if(context.nextFocusedView == self) {
        [coordinator addCoordinatedAnimations:^{
            for(UIView *view in self.contentView.subviews) {
                if([view isKindOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel *)view;
                    label.textColor = [UIColor blackColor];
                }
            }
        } completion:NULL];
    } else {
        [coordinator addCoordinatedAnimations:^{
            for(UIView *view in self.contentView.subviews) {
                if([view isKindOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel *)view;
                    label.textColor = [UIColor labelColor];
                }
            }
        } completion:NULL];
    }
}

@end
