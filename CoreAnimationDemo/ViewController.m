//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by Chen, Duanjin on 4/19/14.
//  Copyright (c) 2014 dj-chen. All rights reserved.
//

#import "ViewController.h"
#import "ViewContainer.h"

@interface ViewController ()

@property (nonatomic, strong)UIView* containerView1;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.containerView1 = [[ViewContainer alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.containerView1];
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer* swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.containerView1 addGestureRecognizer:swipe];
    [self.containerView1 addGestureRecognizer:swipeLeft];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleSwipe:(UISwipeGestureRecognizer*)gesture
{
    if (gesture.direction & UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Swipe Left");
    }
    if (gesture.direction & UISwipeGestureRecognizerDirectionRight){
        NSLog(@"Swipe Right");
    }
        
}

@end
