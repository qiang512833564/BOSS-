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
#import "AppDelegate.h"
#import "TableViewCell.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *mytableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"View" bundle:nil] forCellReuseIdentifier:@"CellID"];
    self.mytableView.backgroundColor = ((AppDelegate *)[UIApplication sharedApplication].delegate).backColor;
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.mytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//    }];
    self.mytableView.mj_header = [MyHeader headerWithRefreshingBlock:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"startAnimation" object:nil];
    }];
    //self.mytableView.mj_header.backgroundColor = [UIColor purpleColor];
    
//    AnimationView *animationView =[[AnimationView alloc]initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)];
//    animationView.backgroundColor = [UIColor greenColor];
//    [self.mytableView.mj_header addSubview:animationView];
    [self.mytableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10-5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UITableView *tableview = (UITableView *)object;
        MyHeader *header = (MyHeader *)self.mytableView.mj_header;
        [header refreshHeaderView:tableview.contentOffset.y];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 164;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellID";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    //if (cell == nil) {
       // cell = [[[NSBundle mainBundle]loadNibNamed:@"View" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
