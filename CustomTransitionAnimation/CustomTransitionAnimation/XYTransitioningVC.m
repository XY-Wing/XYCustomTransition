//
//  XYTransitioningVC.m
//  CustomTransitionAnimation
//
//  Created by wing on 2018/5/18.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYTransitioningVC.h"
#import "XYInteractiveTransition.h"
@interface XYTransitioningVC ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,strong)XYInteractiveTransition *XYT;
@end

@implementation XYTransitioningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    _XYT = [XYInteractiveTransition interactiveTransitionWithTransitionType:XYInteractiveTransitionTypeDismiss GestureDirection:XYInteractiveTransitionGestureDirectionRight forViewController:self];
    
    
    self.transitioningDelegate = self;
    [self setupUI];
    
}
- (void)setupUI
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(200, 200, 100, 100);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(transitioning:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    NSLog(@"a = %@",NSStringFromCGRect(self.view.bounds));
    
    
}
- (void)transitioning:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NSLog(@"presented = %@,presenting = %@,source = %@",presented,presenting,source);
    _isPush = YES;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NSLog(@"dismissed = %@",dismissed);
    _isPush = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (_isPush) {
        UIView *motionlessV = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *animatingV = [transitionContext viewForKey:UITransitionContextToViewKey];
        animatingV.transform = CGAffineTransformMakeTranslation(screenW, 0);
        [transitionContext.containerView addSubview:animatingV];
        
        
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            motionlessV.transform = CGAffineTransformMakeScale(0.9, 0.9);
            animatingV.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

        }];
        
        
    }
    else {
        UIView *motionlessV = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *animatingV = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [transitionContext.containerView addSubview:motionlessV];
        [transitionContext.containerView addSubview:animatingV];
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            motionlessV.transform = CGAffineTransformIdentity;
            animatingV.transform = CGAffineTransformMakeTranslation(screenW, 0);
        } completion:^(BOOL finished) {

            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        }];
    }
}
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return _XYT.interation ? _XYT : nil;
}
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return _presentTransition.interation ? _presentTransition : nil;
}
- (void)dealloc
{
    NSLog(@"aaa");
}
@end
