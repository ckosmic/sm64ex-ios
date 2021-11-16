//
//  TVOSSwitch.m
//  sm64ios
//
//  Created by Christian Kosman on 11/12/21.
//
//  From DOLATVSwitchCell from DolphiniOS
//  https://github.com/OatmealDome/dolphin/blob/ios-jb/Source/iOS/DolphiniOS/DolphinATV/UI/Util/DOLATVSwitchCell.m
//

#import "TVOSSwitch.h"

@implementation TVOSSwitch

@synthesize on;
@synthesize callback;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.switchLabel = [[UILabel alloc] init];
    [self.switchLabel setText:@"Disabled"];
    [self.switchLabel setTextAlignment:NSTextAlignmentRight];
    [self.switchLabel setTextColor:[UIColor secondaryLabelColor]];
    [self.switchLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.contentView addSubview:self.switchLabel];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.switchLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailingMargin multiplier:1 constant:0];
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.switchLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.switchLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTopMargin multiplier:1 constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.switchLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottomMargin multiplier:1 constant:0];
    
    [self addConstraints:@[trailingConstraint, leadingConstraint, topConstraint, bottomConstraint]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if(selected) {
        [self setOn:!self.isOn];
    }
}

- (void)setOn:(BOOL)on {
    self->on = on;
    if(self->on) {
        [self.switchLabel setText:@"Enabled"];
    } else {
        [self.switchLabel setText:@"Disabled"];
    }
    
    if(self.callback != nil) {
        self.callback();
    }
}

@end
