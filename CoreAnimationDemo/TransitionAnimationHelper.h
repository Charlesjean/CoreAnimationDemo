//
//  TransitionAnimationHelper.h
//  CoreAnimationDemo
//
//  Created by Chen, Duanjin on 4/19/14.
//  Copyright (c) 2014 dj-chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(int, Direction)
{
    AnimationDirection_Left,
    AnimationDirection_Right
};
typedef NS_ENUM(int, AnimationType)
{
    AnimationType_Folder,
    AnimationType_Accordion
};

@interface TransitionAnimationHelper : NSObject
@property (nonatomic, assign)CGFloat animationDuration;
@property (nonatomic, assign)AnimationType animationType;
@property (nonatomic, assign)Direction animationDirection;

- (id)initWithAnimationType:(AnimationType)type withDuration:(CGFloat)duration
              withDirection:(Direction)direction;

- (void)performAnimationWithContainer:(UIView*)containerView
                      withCurrentView:(UIView*)currentView
                         withNextView:(UIView*)nextView;


@end
