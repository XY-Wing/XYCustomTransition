//
//  XYTransitioning3VC.m
//  CustomTransitionAnimation
//
//  Created by wing on 2018/5/18.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYTransitioning3VC.h"
#import "XYPercentDrivenInteractiveTransition.h"
#import "XYInteractiveTransition.h"
@interface XYTransitioning3VC ()<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,strong)XYPercentDrivenInteractiveTransition *transition;
@property(nonatomic,strong)XYInteractiveTransition *XYT;
@end

@implementation XYTransitioning3VC
- (instancetype)init
{
    if (self = [super init]) {
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        _transition = [[XYPercentDrivenInteractiveTransition alloc] init];
        [_transition addPanGestureForAnimatingViewController:self];
        
        _XYT = [XYInteractiveTransition interactiveTransitionWithTransitionType:XYInteractiveTransitionTypeDismiss GestureDirection:XYInteractiveTransitionGestureDirectionDown forViewController:self];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor blackColor];
    v.frame = CGRectMake(100, 50, 100, 100);
    [v addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aaaa)]];
    [self.view addSubview:v];
}
- (void)aaaa
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (_isPresent) {
        UIView *animatingV = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *motionlessV = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        animatingV.frame = CGRectMake(20, screenH, screenW - 40, screenH-200);
        UIView *motionlessSnapShotV = [motionlessV snapshotViewAfterScreenUpdates:NO];
//        motionlessSnapShotV.frame = self.view.bounds;
        motionlessV.hidden = YES;
        [transitionContext.containerView addSubview:motionlessSnapShotV];
        [transitionContext.containerView addSubview:animatingV];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            animatingV.frame = CGRectMake(0, 200, screenW, screenH-200);
            motionlessSnapShotV.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [motionlessSnapShotV removeFromSuperview];
            }
        }];
    } else {
        UIView *animatingV = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *motionlessV = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        UIView *motionlessSnapShotV = transitionContext.containerView.subviews.firstObject;
        [transitionContext.containerView addSubview:animatingV];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            animatingV.frame = CGRectMake(0, screenH, screenW, screenH-200);
            motionlessSnapShotV.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            motionlessV.hidden = NO;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                
            }
        }];
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _isPresent = YES;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _isPresent = NO;
    return self;
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//
//    return _transition;
//}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return _XYT.interation ? _XYT : nil;
}
@end
