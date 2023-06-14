//
//  TVOSSlider.h
//  sm64tvos
//
//  Created by Christian Kosman on 6/11/23.
//

#ifndef TVOSSlider_h
#define TVOSSlider_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface TVOSSlider : UIControl

@property(strong, nonatomic) IBOutlet UIView *contentView;
@property(weak, nonatomic) IBOutlet UIProgressView *progressView;
@property(weak, nonatomic) IBOutlet UIImageView *knobView;

@property(nonatomic, getter=getValue, setter=setValue:) IBInspectable float value;

@property(nonatomic) IBInspectable float minimumValue;
@property(nonatomic) IBInspectable float maximumValue;
@property(nonatomic) IBInspectable float stepAmount;

- (void)setValue:(float)value animated:(BOOL)animated;

@end


#endif /* TVOSSlider_h */
