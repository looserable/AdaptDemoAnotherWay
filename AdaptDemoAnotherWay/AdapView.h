//
//  AdapView.h
//  AdaptDemoAnotherWay
//
//  Created by john on 16/3/30.
//  Copyright © 2016年 jhon. All rights reserved.
//

#import <UIKit/UIKit.h>

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
 *  图片
 */
@property (nonatomic,strong)UIImageView * picImgVC;
@property (nonatomic,copy)NSString * imageName;



@end
