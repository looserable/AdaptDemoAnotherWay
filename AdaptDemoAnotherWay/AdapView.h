//
//  AdapView.h
//  AdaptDemoAnotherWay
//
//  Created by john on 16/3/30.
//  Copyright © 2016年 jhon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BigImgDelegate <NSObject>

- (void)clickForImageView:(UIImageView *)imageView andBigerImage:(UIImage *)image;

@end

@interface AdapView : UIView

/**
 *  标题
 */
@property (nonatomic,strong)UILabel * titleLb;
@property (nonatomic,copy)NSString * title;

/**
 *  内容
 */
@property (nonatomic,strong)UILabel * contentLb;
@property (nonatomic,copy)NSString * content;

/**
 *  图片数组
 */
@property (nonatomic,copy)NSArray * imgArray;

@property (nonatomic,assign)id <BigImgDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andImgArray:(NSArray *)imgArray;

@end
