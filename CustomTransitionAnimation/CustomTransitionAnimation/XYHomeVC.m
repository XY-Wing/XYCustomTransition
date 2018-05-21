//
//  XYHomeVC.m
//  CustomTransitionAnimation
//
//  Created by wing on 2018/5/18.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYHomeVC.h"
#import "XYTransitioningVC.h"
#import "XYTransitioning2VC.h"
#import "XYTransitioning3VC.h"
#import "XYInteractiveTransition.h"
@interface XYHomeVC ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)XYInteractiveTransition *transition;
@end

@implementation XYHomeVC
- (UITableView *)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
//        _tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _tableV;
}
- (instancetype)init
{
    if (self = [super init])
    {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _transition = [XYInteractiveTransition interactiveTransitionWithTransitionType:XYInteractiveTransitionTypePresent GestureDirection:XYInteractiveTransitionGestureDirectionLeft forViewController:self];
        typeof(self) weakSelf = self;
        _transition.presentConifg = ^(){
            [weakSelf transitioning];
        };
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _titleArr = ({
        NSArray *arr = @[@"动画1",@"动画2",@"动画3"];
        arr;
    });
    [self.view addSubview:self.tableV];
}
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return _transition.interation ? _transition:nil;
}
#pragma mark --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = _titleArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self transitioning];
            break;
        case 1:
            [self transitioning2];
            break;
        case 2:
            [self transitioning3];
            break;
            
        default:
            break;
    }
}
- (void)transitioning
{
    XYTransitioningVC *vc = [[XYTransitioningVC alloc] init];
    vc.presentTransition = _transition;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)transitioning2
{
    XYTransitioning2VC *vc = [[XYTransitioning2VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)transitioning3
{
    XYTransitioning3VC *vc = [[XYTransitioning3VC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
