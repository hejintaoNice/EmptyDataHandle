//
//  ViewController.m
//  空数据
//
//  Created by hejintao on 16/10/7.
//  Copyright © 2016年 hejintao. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "LeftTableViewCell.h"
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    UITableView *_leftTableView;
    NSMutableArray *_leftArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _leftArray = [NSMutableArray arrayWithCapacity:0];
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.backgroundColor = [UIColor whiteColor];
    _leftTableView.dataSource = self;
    
    _leftTableView.emptyDataSetSource = self;
    _leftTableView.emptyDataSetDelegate = self;
    
    
    
    _leftTableView.tableHeaderView = [UIView new];
    _leftTableView.tableFooterView = [UIView new];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_leftTableView registerNib:[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"leftMessageID"];
    [_leftTableView registerNib:[UINib nibWithNibName:@"LeftTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"leftTwoMessageID"];
    _leftTableView.estimatedRowHeight = 44.0f;
    _leftTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_leftTableView];
}
//没有数据的时候 放一张图片占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"icon_none_data"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
//点击当前数据空白处时  可以刷新
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (_leftTableView == scrollView) {
        //开始刷新
        NSLog(@"开始刷新");
    }
}
//没有数据的时候  tabbleView等  是否可以滚动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
//没有数据的时候添加文字提示
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"这里还什么都没有";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _leftArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMessageID"];
        if (!cell) {
            cell = (LeftTableViewCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"leftMessageID"];
        }
        cell.name.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
