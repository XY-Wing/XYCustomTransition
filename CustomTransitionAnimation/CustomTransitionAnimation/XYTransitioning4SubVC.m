//
//  XYTransitioning4SubVC.m
//  CustomTransitionAnimation
//
//  Created by wing on 2018/5/25.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYTransitioning4SubVC.h"
#import "XYInteractiveTransition.h"
@interface XYTransitioning4SubVC ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
@property(nonatomic,strong)XYInteractiveTransition *transition;
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,strong)UIImageView *imgV;
@end

@implementation XYTransitioning4SubVC
- (instancetype)init
{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        _transition = [XYInteractiveTransition interactiveTransitionWithTransitionType:XYInteractiveTransitionTypeDismiss GestureDirection:XYInteractiveTransitionGestureDirectionRight forViewController:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *_imgV = [[UIImageView alloc] initWithFrame:CGRectMake(87.5, 64, 200, 200)];
    _imgV.image = [UIImage imageNamed:@"avatar.jpg"];
    _imgV.userInteractionEnabled = YES;
    [self.view addSubview:_imgV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_imgV addGestureRecognizer:tap];

    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 264, 375, 375)];
    lab.text = @"测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画测试一下转场动画";
    lab.numberOfLines = 0;
    [self.view addSubview:lab];
}
- (void)tap
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
        UIView *whiteV = [[UIView alloc] initWithFrame:self.view.bounds];
        whiteV.backgroundColor = [UIColor whiteColor];
        UIView *toV = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        toV.alpha = 0;
        _animatingV.frame = CGRectMake(87.5, 264, 200, 200);
        [transitionContext.containerView addSubview:whiteV];
        [transitionContext.containerView addSubview:_animatingV];
        [transitionContext.containerView addSubview:toV];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            _animatingV.transform = CGAffineTransformMakeTranslation(0, -200);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if (![transitionContext transitionWasCancelled]) {
                [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                    toV.alpha = 1;
                }];
            }
        }];
    } else {
        UIView *whiteV = [[UIView alloc] initWithFrame:self.view.bounds];
        whiteV.backgroundColor = [UIColor whiteColor];
        UIView *fromV = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        [transitionContext.containerView addSubview:whiteV];
        [transitionContext.containerView addSubview:fromV];
        [transitionContext.containerView addSubview:_animatingV];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromV.alpha = 0;
        } completion:^(BOOL finished) {
                [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                    _animatingV.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                }];
            
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
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return _transition.interation ? _transition : nil;
}
@end
