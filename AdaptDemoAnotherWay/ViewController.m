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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,BigImgDelegate>
{
    UITableView * tableview;
    NSArray * _titleArray;
    NSArray * _contentArray;
    NSArray * _imageNameArray;
//    记录放大前的imageView的frame
    CGRect oldFrame;
//    记录放大前的image对象。将来肯定是要联网的，那么，如果后台给力的话，这里记录的应该是bigPicUrl。
    UIImage * oldImage;
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
    
    tableview.tableFooterView = [UIView new];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    如果cell上面原来子视图，那么移除
    for (AdapView * adaptV in cell.contentView.subviews) {
        if ([adaptV isKindOfClass:[AdapView class]]) {
            [adaptV removeFromSuperview];
            break;
        }
    }
//    创建自适应的视图，通过赋值触发自动布局，这里初始化的时候一定要给出宽度，不然会造成点击无响应的问题。
    AdapView * adap = [[AdapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) andImgArray:_imageNameArray[indexPath.row]];
    adap.title = _titleArray[indexPath.row];
    adap.content = _contentArray[indexPath.row];
    adap.imgArray = _imageNameArray[indexPath.row];
    adap.delegate = self;
    adap.userInteractionEnabled = YES;
    cell.frame = adap.frame;
    
    [cell.contentView addSubview:adap];
    return cell;
}

- (void)click:(UIButton *)sender{
    NSLog(@"hfhasfs");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height+15;
}

-(void)clickForImageView:(UIImageView *)imageView andBigerImage:(UIImage *)image{
    
    UIView * backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backGroundView.backgroundColor = [UIColor blackColor];
    backGroundView.alpha = 0;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:backGroundView];
    
    oldFrame = [imageView convertRect:imageView.bounds toView:window];
    UIImageView * newImagView = [[UIImageView alloc]initWithFrame:oldFrame];
    newImagView.image = image;
    
    newImagView.tag = 1;
    [backGroundView addSubview:newImagView];
    
    [UIView animateWithDuration:0.3 animations:^{
        newImagView.frame = CGRectMake(0, SCREEN_HEIGHT/2.0 - 100, SCREEN_WIDTH, 200);
        backGroundView.alpha = 1;
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backGroundView addGestureRecognizer:tap];
    
}

- (void)hideImage:(UITapGestureRecognizer *)tap{
    
    UIView * backGroundView = tap.view;
    
    UIImageView * imageView = (UIImageView *)[backGroundView viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldFrame;
        imageView.image = oldImage;
        backGroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backGroundView removeFromSuperview];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"haha");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
