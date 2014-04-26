//
//  TransitionAnimationHelper.m
//  CoreAnimationDemo
//
//  Created by Chen, Duanjin on 4/19/14.
//  Copyright (c) 2014 dj-chen. All rights reserved.
//

#import "TransitionAnimationHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "FolderAnimation.h"
#import "AccordionAnimation.h"


@interface TransitionAnimationHelper()
{
    UIView* _container;
    UIView* _currentView;
    UIView* _nextView;
    
}
- (void)performFolderAnimation;
- (void)performAccordionAnimation;
- (UIImage*)getImageFromView:(UIView*)view;

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

- (void)performAnimationWithContainer:(UIView *)containerView withCurrentView:(UIView *)currentView withNextView:(UIView *)nextView
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
    FolderAnimation* folderAnimation = [[FolderAnimation alloc] init];
    [self setUpParamForAnimation:folderAnimation];
    [folderAnimation prepareLayerHierarchyForAnimation];
    [folderAnimation performAnimation];
}

- (void)performAccordionAnimation
{
    AccordionAnimation* accordionAnimation = [[AccordionAnimation alloc] init];
    [self setUpParamForAnimation:accordionAnimation];
    [accordionAnimation prepareLayerHierarchyForAnimation];
    [accordionAnimation performAnimation];
}

- (void)setUpParamForAnimation:(CustomAnimation*)animation
{
    animation.containerView = _container;
    animation.currentView = _currentView;
    animation.nextView = _nextView;
    animation.duration = self.animationDuration;
    animation.animationDirection = self.animationDirection;
}
@end
