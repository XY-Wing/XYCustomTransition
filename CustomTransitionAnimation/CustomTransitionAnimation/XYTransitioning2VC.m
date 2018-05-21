//
//  XYTransitioning2VC.m
//  CustomTransitionAnimation
//
//  Created by wing on 2018/5/18.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYTransitioning2VC.h"

@interface XYTransitioning2VC ()<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>
@end

@implementation XYTransitioning2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationController.delegate = self;
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //pop动画
        UIView *motionlessV = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *animatingV = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [transitionContext.containerView addSubview:motionlessV];
        [transitionContext.containerView addSubview:animatingV];
        motionlessV.transform = CGAffineTransformMakeScale(0.5, 0.5);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            motionlessV.transform = CGAffineTransformIdentity;
            animatingV.transform = CGAffineTransformMakeTranslation(screenW, 0);
            animatingV.transform = CGAffineTransformScale(animatingV.transform, 0.5, 0.5);
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
            
        }];
}
#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self;
}
@end
