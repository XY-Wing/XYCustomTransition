//
//  XYInteractiveTransition.m
//  XYTrasitionPractice
//
//  Created by wing on 2018/5/18.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYInteractiveTransition.h"

@interface XYInteractiveTransition ()

@property (nonatomic, weak) UIViewController *vc;
/**手势方向*/
@property (nonatomic, assign) XYInteractiveTransitionGestureDirection direction;
/**手势类型*/
@property (nonatomic, assign) XYInteractiveTransitionType type;

@end

@implementation XYInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(XYInteractiveTransitionType)type GestureDirection:(XYInteractiveTransitionGestureDirection)direction forViewController:(UIViewController *)vc
{
    return [[self alloc] initWithTransitionType:type GestureDirection:direction forViewController:vc];
}

- (instancetype)initWithTransitionType:(XYInteractiveTransitionType)type GestureDirection:(XYInteractiveTransitionGestureDirection)direction forViewController:(UIViewController *)vc
{
    self = [super init];
    if (self) {
        self.completionCurve = UIViewAnimationCurveLinear;
        _direction = direction;
        _type = type;
        _vc = vc;
        [self addPanGestureForViewController:vc];
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [viewController.view addGestureRecognizer:pan];
}

/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case XYInteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case XYInteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case XYInteractiveTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case XYInteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (persent > 0.25) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

- (void)startGesture{
    switch (_type) {
        case XYInteractiveTransitionTypePresent:{
            if (_presentConifg) {
                _presentConifg();
            }
        }
            break;
            
        case XYInteractiveTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case XYInteractiveTransitionTypePush:{
            if (_pushConifg) {
                _pushConifg();
            }
        }
            break;
        case XYInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}
@end
