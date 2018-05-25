//
//  XYTransitioning4VC.m
//  CustomTransitionAnimation
//
//  Created by wing on 2018/5/25.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYTransitioning4VC.h"
#import "XYTransitioning4SubVC.h"
@interface XYTransitioning4VC ()
@property(nonatomic,strong)UIImageView *imgV;
@end

@implementation XYTransitioning4VC
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _imgV.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(87.5, 264, 200, 200)];
    _imgV.image = [UIImage imageNamed:@"avatar.jpg"];
    _imgV.userInteractionEnabled = YES;
    [self.view addSubview:_imgV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_imgV addGestureRecognizer:tap];
}
- (void)tap
{
    XYTransitioning4SubVC *sub = [[XYTransitioning4SubVC alloc] init];
    sub.animatingV = [_imgV snapshotViewAfterScreenUpdates:NO];
    [self presentViewController:sub animated:YES completion:nil];
    _imgV.hidden = YES;
}
@end
