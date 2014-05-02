//
//  AccordionAnimation.m
//  CoreAnimationDemo
//
//  Created by Chen, Duanjin on 4/26/14.
//  Copyright (c) 2014 dj-chen. All rights reserved.
//

#import "AccordionAnimation.h"
#import <QuartzCore/QuartzCore.h>
@interface AccordionAnimation()
{
    CATransformLayer* accordParentLayer;
    CATransformLayer* accordLayer;
    CALayer* currentViewLeftLayer;
    CALayer* currentViewRightLayer;
    
    CALayer* nextViewLayer;
}

@end

@implementation AccordionAnimation


- (id)init
{
    if (self = [super init]) {
        accordParentLayer = [[CATransformLayer alloc] init];
        accordLayer = [[CATransformLayer alloc] init];
        currentViewLeftLayer = [[CALayer alloc] init];
        currentViewRightLayer = [[CALayer alloc] init];
        
        nextViewLayer = [[CALayer alloc] init];
    }
    
    return self;
}

- (void)prepareLayerHierarchyForAnimation
{
    UIImage* currentViewImage = [(UIImageView*)self.currentView image];
    UIImage* nextViewImage = [(UIImageView*)self.nextView image];
    
    [self.currentView removeFromSuperview];
    
    currentViewLeftLayer.contents = (__bridge id)currentViewImage.CGImage;
    currentViewLeftLayer.contentsGravity = kCAGravityLeft;
    currentViewLeftLayer.masksToBounds = YES;
    
    currentViewRightLayer.contents = (__bridge id)(currentViewImage.CGImage);
    currentViewRightLayer.contentsGravity = kCAGravityRight;
    currentViewRightLayer.masksToBounds = YES;
    
    CGSize containerSize = self.containerView.bounds.size;
    CGRect leftLayerRect = CGRectMake(containerSize.width / 4, 0, containerSize.width / 2, containerSize.height);
    CGRect rightLayerRect = CGRectMake(containerSize.width / 4, 0, containerSize.width / 2, containerSize.height);
    CGRect accordLayerRect = CGRectMake(0, 0, containerSize.width, containerSize.height);

    [accordParentLayer addSublayer:accordLayer];
    [accordLayer addSublayer:currentViewLeftLayer];
    [accordLayer addSublayer:currentViewRightLayer];
    [currentViewLeftLayer setFrame:leftLayerRect];
    [currentViewRightLayer setFrame:rightLayerRect];
    [self.containerView.layer addSublayer:accordLayer];
    
    [accordLayer setFrame:accordLayerRect];
    currentViewLeftLayer.anchorPoint = CGPointMake(1.0, 0.5);
    currentViewRightLayer.anchorPoint = CGPointMake(0.0, 0.5);    

    nextViewLayer.contents = (__bridge id)(nextViewImage.CGImage);
    CGRect nextViewLayerRect;
    
    if (self.animationDirection == AnimationDirection_Left) {
        nextViewLayerRect = CGRectMake(containerSize.width, 0, containerSize.width, containerSize.height);
    }
    else{
        nextViewLayerRect = CGRectMake(-containerSize.width, 0, containerSize.width, containerSize.height);
    }
    [nextViewLayer setFrame:nextViewLayerRect];
    [self.containerView.layer addSublayer:nextViewLayer];
}

- (void)performAnimation
{
    float minus = self.animationDirection == AnimationDirection_Left ? -1 : 1;
    int segment = 40;
    float width = self.containerView.bounds.size.width;
    float half_width = width / 2;
    
    CATransform3D leftTransform2 = CATransform3DIdentity;
    leftTransform2.m34 = -1.0/5000;
    CAKeyframeAnimation* moveBackAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.z"];
    NSMutableArray* moveBackValues = [[NSMutableArray alloc] initWithCapacity:segment];
    NSMutableArray* moveValues = [[NSMutableArray alloc] initWithCapacity:segment];
    for (int i = 0; i < segment; ++i) {
        [moveBackValues addObject:[NSNumber numberWithFloat: -half_width * sinf(i * M_PI_2 / segment)]];
        [moveValues addObject:[NSNumber numberWithFloat: minus * half_width * ( 1 - cosf(i * M_PI_2 / segment))]];
    }
    moveBackAnim.values = moveBackValues;
    moveBackAnim.calculationMode = kCAAnimationCubic;
    moveBackAnim.duration = self.duration;
    moveBackAnim.removedOnCompletion = YES;
    moveBackAnim.delegate = self;
    accordLayer.transform = leftTransform2;
    [accordLayer addAnimation:moveBackAnim forKey:@"moveBack"];
    
    CAKeyframeAnimation* moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    moveAnim.values = moveValues;
    moveAnim.calculationMode = kCAAnimationCubic;
    moveAnim.duration = self.duration;
    moveAnim.removedOnCompletion = YES;
    [accordLayer addAnimation:moveAnim forKey:@"move"];
    
    CAKeyframeAnimation* leftRotateAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
    CAKeyframeAnimation* rightRotateAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
    NSMutableArray* leftRotateValues = [[NSMutableArray alloc] initWithCapacity:segment];
    NSMutableArray* rightRotateValues = [[NSMutableArray alloc] initWithCapacity:segment];
    
    for (int i = 0; i < segment; ++i) {
        [leftRotateValues addObject:[NSNumber numberWithFloat:i * M_PI_2 / segment]];
        [rightRotateValues addObject:[NSNumber numberWithFloat:-i * M_PI_2 / segment]];
    }
    leftRotateAnim.values = leftRotateValues;
    leftRotateAnim.duration = self.duration;
    leftRotateAnim.removedOnCompletion = YES;
    [currentViewLeftLayer addAnimation:leftRotateAnim forKey:@"leftAnimation"];
    
    rightRotateAnim.values = rightRotateValues;
    rightRotateAnim.duration = self.duration;
    rightRotateAnim.removedOnCompletion = YES;
    [currentViewRightLayer addAnimation:rightRotateAnim forKey:@"rightAnimation"];
    
    CAKeyframeAnimation* slideInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    NSMutableArray* slideValues = [[NSMutableArray alloc] initWithCapacity:segment];
    for (int i = 0; i < segment; ++i) {
        [slideValues addObject:[NSNumber numberWithFloat: minus * 2 * half_width * ( 1 - cosf(i * M_PI_2 / segment))]];
    }
    slideInAnimation.values = slideValues;
    slideInAnimation.duration = self.duration;
    [nextViewLayer addAnimation:slideInAnimation forKey:@"slidein"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [accordLayer removeFromSuperlayer];
    [nextViewLayer removeFromSuperlayer];
    [self.containerView addSubview:self.nextView];
}

@end
