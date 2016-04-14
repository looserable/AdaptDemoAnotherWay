//
//  AdapView.m
//  AdaptDemoAnotherWay
//
//  Created by john on 16/3/30.
//  Copyright © 2016年 jhon. All rights reserved.
//

#import "AdapView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IMG_TAG 9999

//一张图片时布局imageView需要的高度
#define ONE_PIC_NEED_HEIGHT 120

//两张图片时布局imageView需要的高度
#define TWO_PIC_NEED_HEIGHT 80

//三张以上的图片需要的高度
#define THREE_PIC_OR_MORE_NEED_PICHEIGHT 60

@implementation AdapView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame andImgArray:(NSArray *)imgArray{
    if (self = [super initWithFrame:frame]) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLb.numberOfLines = 0;
        [self addSubview:_titleLb];
        
        _contentLb = [[UILabel alloc]initWithFrame:CGRectZero];
        _contentLb.numberOfLines = 0;
        [self addSubview:_contentLb];
        
        for (NSInteger i = 0; i < imgArray.count; i ++) {
            if (i == 9) {
                break;
            }
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            imageView.tag = IMG_TAG + i;
            imageView.userInteractionEnabled = YES;
            
            [self addSubview:imageView];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [imageView addGestureRecognizer:tap];
            
        }
        [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"content" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"imgArray" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    
    self.userInteractionEnabled = YES;
    return self;
}
- (void)awakeFromNib{
    self.userInteractionEnabled = YES;
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"content"];
    [self removeObserver:self forKeyPath:@"imgArray"];
    
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    NSInteger index = tap.view.tag - IMG_TAG;
    UIImageView * imageView = (UIImageView *)[self viewWithTag:tap.view.tag];
    NSLog(@"进来了");
    UIImage * image = [UIImage imageNamed:_imgArray[index]];
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickForImageView:andBigerImage:)]) {
        [_delegate clickForImageView:imageView andBigerImage:image];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
//    每一个模块儿的坐标起点
    CGFloat Mudel_Y = 0.0;
    
//    根据属性的值的变化来调整视图上的控件的位置
    if ([keyPath isEqualToString:@"title"]) {//标题
        _titleLb.text = _title;
        CGSize realSize = [_titleLb.text sizeWithFont:_titleLb.font constrainedToSize:CGSizeMake(SCREEN_WIDTH - 20, 11000) lineBreakMode:NSLineBreakByWordWrapping];
        _titleLb.frame = CGRectMake(10, 5, SCREEN_WIDTH - 20, realSize.height);
        
    }else if ([keyPath isEqualToString:@"content"]){//内容
        _contentLb.text = _content;
        CGSize realSize = [_contentLb.text sizeWithFont:_contentLb.font constrainedToSize:CGSizeMake(SCREEN_WIDTH - 20, 11000) lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat titleHeight = _titleLb.frame.size.height + 5;
        _contentLb.frame = CGRectMake(10, titleHeight + 5, SCREEN_WIDTH - 20, realSize.height);
        
    }else{//图片
//        图片模块儿最开始的坐标从这里开始
        Mudel_Y = _contentLb.frame.origin.y + _contentLb.frame.size.height + 10;
        
        if (_imgArray.count == 1) {
//        如果只有一张图片的话
            UIImageView * imageView = (UIImageView *)[self viewWithTag:IMG_TAG];
            imageView.frame = CGRectMake(10, Mudel_Y + 10, SCREEN_WIDTH - 20, ONE_PIC_NEED_HEIGHT);
            imageView.image = [UIImage imageNamed:_imgArray[0]];
            
        }else if (_imgArray.count == 2){
//        如果有两张图片
            for (NSInteger i = 0; i < 2; i ++) {
                
                UIImageView * imageView = (UIImageView *)[self viewWithTag:IMG_TAG + i];
                imageView.frame = CGRectMake(10 + i * ((SCREEN_WIDTH - 20)/2.0), Mudel_Y + 10, (SCREEN_WIDTH - 20 - 10)/2.0, TWO_PIC_NEED_HEIGHT);
                imageView.image = [UIImage imageNamed:_imgArray[i]];
                
            }
            
        }else if (_imgArray.count >= 3 && _imgArray.count <= 9){
//        如果有三张以上以及更多的图片
            for (NSInteger i = 0; i < _imgArray.count; i ++) {
                NSString * imageName = _imgArray[i];
                UIImageView * imgVC = (UIImageView *)[self viewWithTag:IMG_TAG + i];
                imgVC.image = [UIImage imageNamed:imageName];
                imgVC.frame = CGRectMake(10 + (i%3) *(SCREEN_WIDTH - 20)/3.0, Mudel_Y + 10 + (THREE_PIC_OR_MORE_NEED_PICHEIGHT + 5) * (i/3), (SCREEN_WIDTH - 20 - 15)/3.0, THREE_PIC_OR_MORE_NEED_PICHEIGHT);
            }
        }
    }
//    标题Label的高度
    CGFloat titleHeight = _titleLb.frame.size.height;
//    内容Label的高度
    CGFloat contentHeight = _contentLb.frame.size.height;
//    图片模块儿的整个高度初始值为0
    CGFloat picHeight = 0.0;
    
    if (_imgArray.count == 1) {
        picHeight = 120;
    }else if (_imgArray.count == 2){
        picHeight = 80;
    }else if (_imgArray.count >= 3 && _imgArray.count <= 9){
        picHeight = 65 * (_imgArray.count%3 == 0?_imgArray.count/3:_imgArray.count/3 + 1);
    }
    
    CGRect selfFrame = self.frame;
    selfFrame.size.height = titleHeight + contentHeight + picHeight + 20;
    self.frame = selfFrame;
}




@end
