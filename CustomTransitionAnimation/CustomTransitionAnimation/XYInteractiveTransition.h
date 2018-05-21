//
//  XYInteractiveTransition.h
//  XYTrasitionPractice
//
//  Created by wing on 2018/5/18.
//  Copyright © 2018年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureConifg)(void);

typedef NS_ENUM(NSUInteger, XYInteractiveTransitionGestureDirection) {//手势的方向
    XYInteractiveTransitionGestureDirectionLeft = 0,
    XYInteractiveTransitionGestureDirectionRight,
    XYInteractiveTransitionGestureDirectionUp,
    XYInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, XYInteractiveTransitionType) {//手势控制哪种转场
    XYInteractiveTransitionTypePresent = 0,
    XYInteractiveTransitionTypeDismiss,
    XYInteractiveTransitionTypePush,
    XYInteractiveTransitionTypePop,
};

@interface XYInteractiveTransition : UIPercentDrivenInteractiveTransition
/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interation;
/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg presentConifg;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg pushConifg;

//初始化方法

+ (instancetype)interactiveTransitionWithTransitionType:(XYInteractiveTransitionType)type GestureDirection:(XYInteractiveTransitionGestureDirection)direction forViewController:(UIViewController *)vc;
- (instancetype)initWithTransitionType:(XYInteractiveTransitionType)type GestureDirection:(XYInteractiveTransitionGestureDirection)direction forViewController:(UIViewController *)vc;
@end
