//
//  ViewController.m
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "MyHeader.h"
#import "AnimationView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//    }];
    self.tableView.mj_header = [MyHeader headerWithRefreshingBlock:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"startAnimation" object:nil];
    }];
    //self.tableView.mj_header.backgroundColor = [UIColor purpleColor];
    
//    AnimationView *animationView =[[AnimationView alloc]initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)];
//    animationView.backgroundColor = [UIColor greenColor];
//    [self.tableView.mj_header addSubview:animationView];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UITableView *tableview = (UITableView *)object;
        MyHeader *header = (MyHeader *)self.tableView.mj_header;
        [header refreshHeaderView:tableview.contentOffset.y];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
