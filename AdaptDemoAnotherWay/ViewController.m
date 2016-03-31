//
//  ViewController.m
//  AdaptDemoAnotherWay
//
//  Created by john on 16/3/30.
//  Copyright © 2016年 jhon. All rights reserved.
//

#import "ViewController.h"
#import "AdapView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableview;
    NSArray * _titleArray;
    NSArray * _contentArray;
    NSArray * _imageNameArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createTableview];
    
    [self loadData];
    
    [tableview reloadData];
}

- (void)createTableview{
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 20,SCREEN_WIDTH, SCREEN_HEIGHT - 20) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
}

- (void)loadData{
    _titleArray = @[@"zheshyigebiaoti",@"zheshi yige biaoti",@"zheshi yige biaoti"];
     _contentArray = @[@"zheshyigebiaotijfldslfjlsajdfljsdlfjdsljflsjdljflsdjlfjsldjflsdjlfjlsdjflsjfksdkfjkdsjkfjksdjkfjkdsjkfjksdjkfjksdjkfjdkjsfakdsjkfjkjsdkjkfjkdsjkfjkdsjkjfkdskjf",@"zheshi yige biaotifsdlfjlsdjfldsjfljsldjflsdjfljsdljfdsjljfljsdljflsdjfljsldjflkjsdlfjlsdjfkljsdlfdsjhfjdshjfhjdshfjhdjshfjhafjhdjshfjahdfjdhjfhjdshjfhjdshjfhjdshjfhjdsfhajahjdshfjhds",@"zheshi yige biaotijlkjfldsjafljasldfjlsdjflkjdslkjflsdjfljsdljflsdjfljsdlkjflkjsdlfjkldsjlkfjlksdjlfjlsdfkjsdlkfjl"];
     _imageNameArray = @[@[@"2.png",@"2.png"],@[@"2.png",@"2.png",@"2.png",@"2.png",@"2.png",@"2.png",@"2.png",@"2.png"],@[@"2.png"]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    如果cell上面原来子视图，那么移除
    for (AdapView * adaptV in cell.contentView.subviews) {
        if ([adaptV isKindOfClass:[AdapView class]]) {
            [adaptV removeFromSuperview];
            break;
        }
    }
//    创建自适应的视图，通过赋值触发自动布局
    AdapView * adap = [[AdapView alloc]initWithFrame:CGRectZero andImgArray:_imageNameArray[indexPath.row]];
    adap.title = _titleArray[indexPath.row];
    adap.content = _contentArray[indexPath.row];
    adap.imgArray = _imageNameArray[indexPath.row];
    
    cell.frame = adap.frame;
    
    [cell.contentView addSubview:adap];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height+15;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
