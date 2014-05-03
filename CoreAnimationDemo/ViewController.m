//
//  ViewController.m
//  CoreAnimationTest2
//
//  Created by Chen Duanjin on 4/26/14.
//  Copyright (c) 2014 iLife. All rights reserved.
//
#import "ViewController.h"
#import "ViewContainer.h"
#import "TransitionAnimationHelper.h"
@interface ViewController ()
{
    TransitionAnimationHelper* animationHelper;
}

@property (nonatomic, strong)ViewContainer* containerView1;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.containerView1 = [[ViewContainer alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
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
    float duration = 2.0;
    if (gesture.direction & UISwipeGestureRecognizerDirectionLeft) {
        animationHelper = [[TransitionAnimationHelper alloc] initWithAnimationType:AnimationType_Folder withDuration:duration withDirection:AnimationDirection_Left];
        [animationHelper performAnimationWithContainer:self.containerView1 withCurrentView:self.containerView1.currentView withNextView:self.containerView1.nextView];
        NSLog(@"Swipe Left");
    }
    if (gesture.direction & UISwipeGestureRecognizerDirectionRight){
        animationHelper = [[TransitionAnimationHelper alloc] initWithAnimationType:AnimationType_Accordion withDuration:duration withDirection:AnimationDirection_Right];
        [animationHelper performAnimationWithContainer:self.containerView1 withCurrentView:self.containerView1.currentView withNextView:self.containerView1.nextView];
        NSLog(@"Swipe Right");
    }
    
    [self.containerView1 switchView];
}
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}
@end
