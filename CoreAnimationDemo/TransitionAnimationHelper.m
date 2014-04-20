//
//  TransitionAnimationHelper.m
//  CoreAnimationDemo
//
//  Created by Chen, Duanjin on 4/19/14.
//  Copyright (c) 2014 dj-chen. All rights reserved.
//

#import "TransitionAnimationHelper.h"

@interface TransitionAnimationHelper()
{
    UIView* _container;
    UIImageView* _currentView;
    UIImageView* _nextView;
}
- (void)performFolderAnimation;
- (void)performAccordionAnimation;

@end

@implementation TransitionAnimationHelper

 - (id)initWithAnimationType:(AnimationType)type withDuration:(CGFloat)duration withDirection:(Direction)direction
{
    if (self = [super init]) {
        self.animationType = type;
        self.animationDuration = duration;
        self.animationDirection = direction;
    }
    return self;
}

- (void)performAnimationWithContainer:(UIView *)containerView withCurrentView:(UIImageView *)currentView withNextView:(UIImageView *)nextView
{
    _container = containerView;
    _currentView = currentView;
    _nextView = nextView;
    switch (self.animationType) {
        case AnimationType_Accordion:
            [self performAccordionAnimation];
            break;
        case AnimationType_Folder:
            [self performFolderAnimation];
            break;
        default:
            assert("Unknown Animation Type");
            break;
    }
}

- (void)performFolderAnimation
{
    
}

- (void)performAccordionAnimation
{
    
}

@end
