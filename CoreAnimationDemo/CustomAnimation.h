//
//  CustomAnimation.h
//  CoreAnimationDemo
//
//  Created by Chen, Duanjin on 4/26/14.
//  Copyright (c) 2014 dj-chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransitionAnimationHelper.h"
@interface CustomAnimation : NSObject

@property(nonatomic, strong)UIView* containerView;
@property(nonatomic, strong)UIView* currentView;
@property(nonatomic, strong)UIView* nextView;
@property(nonatomic)float duration;
@property(nonatomic)Direction animationDirection;

- (void)prepareLayerHierarchyForAnimation;
- (void)performAnimation;
- (UIImage*)imageFromView:(UIView*)view;
@end
