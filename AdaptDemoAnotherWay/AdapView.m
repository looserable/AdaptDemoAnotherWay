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

@implementation AdapView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLb.numberOfLines = 0;
        [self addSubview:_titleLb];
        _contentLb = [[UILabel alloc]initWithFrame:CGRectZero];
        _contentLb.numberOfLines = 0;
        [self addSubview:_contentLb];
        _picImgVC = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_picImgVC];
        
        [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"content" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"imageName" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"content"];
    [self removeObserver:self forKeyPath:@"imageName"];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
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
        if (_imageName&&[UIImage imageNamed:_imageName]) {
            CGFloat contentY = _contentLb.frame.origin.y + _contentLb.frame.size.height + 10;
            _picImgVC.frame = CGRectMake(10, contentY, SCREEN_WIDTH - 20, 100);
            _picImgVC.image = [UIImage imageNamed:_imageName];
        }
        
    }
    
    CGFloat titleHeight = _titleLb.frame.size.height;
    CGFloat contentHeight = _contentLb.frame.size.height;
    CGFloat picHeight = _picImgVC.frame.size.height;
    
    CGRect selfFrame = self.frame;
    selfFrame.size.height = titleHeight + contentHeight + picHeight + 20;
    self.frame = selfFrame;
}

@end
