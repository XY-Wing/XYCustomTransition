//
//  XYPercentDrivenInteractiveTransition.m
//  CustomTransitionAnimation
//
//  Created by wing on 2018/5/21.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYPercentDrivenInteractiveTransition.h"
@interface XYPercentDrivenInteractiveTransition()
@property(nonatomic,strong)UIViewController *animatingVC;
@end

@implementation XYPercentDrivenInteractiveTransition
- (void)addPanGestureForAnimatingViewController:(UIViewController *)animatingVC
{
    _animatingVC = animatingVC;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [animatingVC.view addGestureRecognizer:panGesture];
    
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
     CGFloat translationY = [panGesture translationInView:_animatingVC.view].y;
    CGFloat ratio = translationY / panGesture.view.frame.size.height;
    NSLog(@"ratio = %f",ratio);
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            {
                _interacting = YES;
                [_animatingVC dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self updateInteractiveTransition:ratio];
        }
        case UIGestureRecognizerStateEnded:
        {
            _interacting = NO;
            if (ratio > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
            break;
            
        default:
            break;
    }
}
@end
