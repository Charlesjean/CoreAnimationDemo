//
//  ViewContainer.m
//  CoreAnimationDemo
//
//  Created by Chen, Duanjin on 4/19/14.
//  Copyright (c) 2014 dj-chen. All rights reserved.
//

#import "ViewContainer.h"

@interface ViewContainer()
@property (nonatomic, strong)UIImageView* firstImageView;
@property (nonatomic, strong)UIImageView* secondImageView;
@property (nonatomic, strong)UIImage* firstImg;
@property (nonatomic, strong)UIImage* secondImg;
@end

@implementation ViewContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.firstImg = [UIImage imageNamed:@"a.jpg"];
        self.secondImg = [UIImage imageNamed:@"b.jpg"];
        self.firstImageView = [[UIImageView alloc] initWithImage:self.firstImg];
        self.secondImageView = [[UIImageView alloc] initWithImage:self.secondImg];
        [self addSubview:self.firstImageView];
    }
    return self;
}

@end