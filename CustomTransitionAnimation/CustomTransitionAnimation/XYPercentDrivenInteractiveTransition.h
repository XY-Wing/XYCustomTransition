//
//  XYPercentDrivenInteractiveTransition.h
//  CustomTransitionAnimation
//
//  Created by wing on 2018/5/21.
//  Copyright © 2018年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XYPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

@property(nonatomic,assign,readonly)BOOL interacting;
- (void)addPanGestureForAnimatingViewController:(UIViewController *)animatingVC;

@end
