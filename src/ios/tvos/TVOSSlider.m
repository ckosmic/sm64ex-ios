//
//  TVOSSlider.m
//  sm64tvos
//
//  Created by Christian Kosman on 6/11/23.
//

#import <math.h>
#import "TVOSSlider.h"

@implementation TVOSSlider

@synthesize value;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        self.minimumValue = 0.0;
        self.maximumValue = 1.0;
        self.stepAmount = 0.1;
        self->value = 0.5;
        
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    [[NSBundle mainBundle] loadNibNamed:@"TVOSSlider" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    self.contentView.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    
    self.knobView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.knobView.layer.shadowOffset = CGSizeMake(0, 5);
    self.knobView.layer.shadowOpacity = 0.75;
    self.knobView.layer.shadowRadius = 4.0;
    self.knobView.clipsToBounds = NO;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [self addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *leftTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeft:)];
    leftTapRecognizer.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypeLeftArrow]];
    leftTapRecognizer.allowedTouchTypes = @[[NSNumber numberWithInteger:UITouchTypeIndirect]];
    [self.contentView addGestureRecognizer:leftTapRecognizer];
    
    UITapGestureRecognizer *rightTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRight:)];
    rightTapRecognizer.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypeRightArrow]];
    rightTapRecognizer.allowedTouchTypes = @[[NSNumber numberWithInteger:UITouchTypeIndirect]];
    [self.contentView addGestureRecognizer:rightTapRecognizer];
}

- (void)tapLeft:(UITapGestureRecognizer *)sender {
    [self setValue:(self->value - self.stepAmount) animated:NO];
}

- (void)tapRight:(UITapGestureRecognizer *)sender {
    [self setValue:(self->value + self.stepAmount) animated:NO];
}

- (void)move:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];
    if (fabs(translation.y) > fabs(translation.x)) {
        return;
    }
    CGPoint velocity = [sender velocityInView:self];
    float newValue = self->value + (velocity.x / 100000.0 * (self.maximumValue - self.minimumValue));
    [self setValue:newValue animated:NO];
}

- (void)setValue:(float)value animated:(BOOL)animated {
    if (value < self.minimumValue) {
        value = self.minimumValue;
    }
    if (value > self.maximumValue) {
        value = self.maximumValue;
    }
    self->value = value;
    
    [self.progressView setProgress:(value / self.maximumValue) animated:NO];
    CGRect bounds = self.knobView.bounds;
    bounds.origin.x = (value / self.maximumValue) * self.bounds.size.width - bounds.size.width / 2;
    bounds.origin.y = self.bounds.size.height / 2 - bounds.size.height / 2;
    self.knobView.frame = bounds;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
