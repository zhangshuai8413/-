//
//  KCBlurEffect.h
//  KCBlur
//
//  Created by 张帅 on 16/3/20.
//  Copyright © 2016年 ZhangShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KCBlurItem,KCBlurEffect;
@protocol KCBlurEffectDelegate <NSObject>


//点击背景dismiss
- (void)blurEffectMenuDidTapOnBackground:(KCBlurEffect *)menu;

//点击item
- (void)blurEffectMenu:(KCBlurEffect *)menu didTapOnItem:(KCBlurItem *)item;


@end

@interface KCBlurItem : NSObject

@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,strong) UIImage *icon;//图标
@end

@interface KCBlurEffect : UIViewController

@property (nonatomic,assign) id<KCBlurEffectDelegate>delegate;
@property (nonatomic,copy) NSArray *menuItemArr;
-(instancetype)initWithMenu:(NSArray*)menu;
@end
