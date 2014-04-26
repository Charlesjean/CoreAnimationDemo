//
//  CustomAnimation.m
//  CoreAnimationDemo
//
//  Created by Chen, Duanjin on 4/26/14.
//  Copyright (c) 2014 dj-chen. All rights reserved.
//

#import "CustomAnimation.h"

@implementation CustomAnimation

- (UIImage *)imageFromView:(UIView *)view
{
    CGColorRef color = view.layer.backgroundColor;
    [view.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer drawInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [view.layer setBackgroundColor:color];
    return image;
}
@end
