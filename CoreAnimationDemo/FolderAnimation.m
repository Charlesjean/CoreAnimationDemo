//
//  FolderAnimation.m
//  CoreAnimationDemo
//
//  Created by Chen, Duanjin on 4/26/14.
//  Copyright (c) 2014 dj-chen. All rights reserved.
//

#import "FolderAnimation.h"
#import <QuartzCore/QuartzCore.h>
@interface FolderAnimation()
{
    CATransformLayer* animationLayer;
    CALayer* frontAnimationLayer;
    CALayer* backAnimationLayer;
    
    CALayer* currentViewHalfLayer;
    CALayer* nextViewHalfLayer;
    
}
@end

@implementation FolderAnimation
- (id)init
{
    if (self = [super init]) {
        animationLayer = [[CATransformLayer alloc] init];
        frontAnimationLayer = [[CALayer alloc] init];
        backAnimationLayer = [[CALayer alloc] init];
        
        currentViewHalfLayer = [[CALayer alloc] init];
        nextViewHalfLayer = [[CALayer alloc] init];
    }
   
    return self;
}

- (void)prepareLayerHierarchyForAnimation
{
    UIImage* currentViewImage = [(UIImageView*)self.currentView image];
    UIImage* nextViewImage = [(UIImageView*) self.nextView image];
    
    float animationAngle;
    [self.currentView removeFromSuperview];
    
    CGRect animationLayerFrame;
    CGRect currentViewHalfLayerRect;
    CGRect nextViewhalfLayerRect;
    
    CGRect containerBound = self.containerView.bounds;
    CGSize containerSize = containerBound.size;
    
    CGRect frontAnimationLayerRect = CGRectMake(0, 0, containerSize.width / 2, containerSize.height);
    CGRect backAnimationLayerRect = CGRectMake(0, 0, containerSize.width / 2, containerSize.height);
    //set layer frame and contents
    if (self.animationDirection == AnimationDirection_Left) {//swipe to left <-
        animationLayerFrame = CGRectMake(containerSize.width / 2, 0, containerSize.width / 2, containerSize.height);
        currentViewHalfLayerRect = CGRectMake(0, 0, containerSize.width / 2, containerSize.height);
        nextViewhalfLayerRect = CGRectMake(containerSize.width / 2, 0, containerSize.width / 2, containerSize.height);
        
        currentViewHalfLayer.contents = (__bridge id)(currentViewImage.CGImage);
        currentViewHalfLayer.contentsGravity = kCAGravityLeft;
        frontAnimationLayer.contents = (__bridge id)(currentViewImage.CGImage);
        frontAnimationLayer.contentsGravity = kCAGravityRight;

        nextViewHalfLayer.contents = (__bridge id)(nextViewImage.CGImage);
        nextViewHalfLayer.contentsGravity = kCAGravityRight;
        backAnimationLayer.contents = (__bridge id)(nextViewImage.CGImage);
        backAnimationLayer.contentsGravity = kCAGravityLeft;
        animationLayer.anchorPoint = CGPointMake(0.0, 0.5);
        animationAngle = 1;

    }
    else
    {
        animationLayerFrame = CGRectMake(0, 0, containerSize.width / 2, containerSize.height);
        currentViewHalfLayerRect = CGRectMake(containerSize.width / 2, 0, containerSize.width / 2, containerSize.height);
        nextViewhalfLayerRect = CGRectMake(0, 0, containerSize.width / 2, containerSize.height);
        
        currentViewHalfLayer.contents = (__bridge id)(currentViewImage.CGImage);
        currentViewHalfLayer.contentsGravity = kCAGravityRight;
        frontAnimationLayer.contents = (__bridge id)(currentViewImage.CGImage);
        frontAnimationLayer.contentsGravity = kCAGravityLeft;
        
        nextViewHalfLayer.contents = (__bridge id)(nextViewImage.CGImage);
        nextViewHalfLayer.contentsGravity = kCAGravityTopLeft;
        backAnimationLayer.contents = (__bridge id)(nextViewImage.CGImage);
        backAnimationLayer.contentsGravity = kCAGravityRight;
        animationLayer.anchorPoint = CGPointMake(1.0, 0.5);
        animationAngle = -1;
        
    }
    //set layer property
    currentViewHalfLayer.masksToBounds = YES;
    frontAnimationLayer.masksToBounds = YES;
    nextViewHalfLayer.masksToBounds = YES;
    backAnimationLayer.masksToBounds = YES;
    currentViewHalfLayer.doubleSided = NO;
    frontAnimationLayer.doubleSided = NO;
    nextViewHalfLayer.doubleSided = NO;
    backAnimationLayer.doubleSided = NO;

    //add underlying layer first
    [self.containerView.layer addSublayer:currentViewHalfLayer];
    [currentViewHalfLayer setFrame:currentViewHalfLayerRect];
    nextViewHalfLayer.anchorPoint = CGPointZero;
    [nextViewHalfLayer setFrame:nextViewhalfLayerRect];
    [self.containerView.layer addSublayer:nextViewHalfLayer];
    //add animation layer;
    
    animationLayer.zPosition = 1000;
    [self.containerView.layer addSublayer:animationLayer];
    [animationLayer setFrame:animationLayerFrame];
    [animationLayer addSublayer:frontAnimationLayer];
    [animationLayer addSublayer:backAnimationLayer];
    [frontAnimationLayer setFrame:frontAnimationLayerRect];
    [backAnimationLayer setFrame:backAnimationLayerRect];
    backAnimationLayer.transform = CATransform3DRotate(CATransform3DIdentity, animationAngle * M_PI, 0, 1, 0);

   }
- (void)performAnimation
{
    int direction = 1;
    if (self.animationDirection == AnimationDirection_Left)
        direction = 1;
    else
        direction = -1;
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform,  direction * M_PI, 0, 1, 0);
    transform.m34 = direction * 1.0/1000;
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.duration = self.duration;
    [animationLayer addAnimation:animation forKey:Nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [animationLayer removeFromSuperlayer];
    [currentViewHalfLayer removeFromSuperlayer];
    [nextViewHalfLayer removeFromSuperlayer];
    [self.containerView addSubview:self.nextView];
}
@end
