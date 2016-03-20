
//
//  KCBlurEffect.m
//  KCBlur
//
//  Created by 张帅 on 16/3/20.
//  Copyright © 2016年 ZhangShuai. All rights reserved.
//


#import "KCBlurEffect.h"

static const CGFloat itemW = 80;
static const CGFloat  itemH = 80;
static const NSInteger totalloc = 3;

@implementation KCBlurItem



@end

@interface KCBlurEffect ()

@end

@implementation KCBlurEffect
-(instancetype)initWithMenu:(NSArray*)menu{
    if (self==[super init]) {
        self.menuItemArr=menu;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
        //手势
    [self gesture];
      //布局View
    [self setUpView];
}

#pragma ------------setUpView

-(void)setUpView{
  //毛玻璃
    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView =[[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [visualEffectView setFrame:self.view.bounds];
    [self.view addSubview:visualEffectView];
    CGFloat margin =(self.view.frame.size.width- totalloc*itemW)/(totalloc +1);
    
    for (int i=0; i< self.menuItemArr.count; ++i) {
        NSInteger row = i/totalloc;
        NSInteger loc = i% totalloc;
        CGFloat itemX = margin+ (margin+ itemW)*loc;
        CGFloat itemY =margin+(margin+ itemH)*row;
        
        //button
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(itemX, -300, itemW, itemH)];
        button.tag=i;
        [button addTarget:self action:@selector(itemBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        //label
        
        UILabel  *label =[[UILabel alloc] init];
        [label setFrame:CGRectMake(itemX, button.frame.origin.y+button.bounds.size.height, itemW, 25)];
        [label setTextColor:[UIColor grayColor]];
        [label setFont:[UIFont systemFontOfSize:14.0]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTag:i];
        [self.view addSubview:label];
        KCBlurItem *item =self.menuItemArr[i];
        [button setImage:item.icon forState:UIControlStateNormal];
        [label setText:item.title];
        
        //Spring Animation
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
        [UIView animateWithDuration:1.f delay:0.2-0.02*i usingSpringWithDamping:1.0 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.frame = CGRectMake(itemX,itemY , itemW,itemH);
            [label setFrame:CGRectMake(itemX, button.frame.origin.y+button.bounds.size.height+5, itemW, 25)];
        } completion:^(BOOL finished) {
            
         }];
        });
    }

}

// 按钮点击
-(void)itemBtnClicked:(UIButton*)sender{
    //点击按钮缩放代码
    [UIView animateWithDuration:0.25 animations:^{
        sender.transform=CGAffineTransformMakeScale(1.7,1.7);
    }];
    //button dismiss动画  Spring Animatio
    [self customAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(blurEffectMenu:didTapOnItem:)]) {
            [_delegate blurEffectMenu:self didTapOnItem:self.menuItemArr[sender.tag]];
        }
    });
    
}


-(void)gesture{
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnBackground)]];
    
    UISwipeGestureRecognizer *swipeGesture =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnBackground)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeGesture];
    
    
}

-(void)didTapOnBackground{
    //点击空白处，dismiss
    [self customAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.delegate&&[_delegate respondsToSelector:@selector(blurEffectMenuDidTapOnBackground:)]) {
            [_delegate blurEffectMenuDidTapOnBackground:self];
        }
    });
    
}
-(void)customAnimation{

    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton   class]]) {
            UIButton *btn=(UIButton *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
          [UIView animateWithDuration:1.f delay:0.02*(btn.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    btn.frame = CGRectMake(btn.frame.origin.x, -300, btn.frame.size.width,btn.frame.size.height);
              } completion:^(BOOL finished) {
                }];
             });
        }
        
         if ([view isKindOfClass:[UILabel class]]) {
             UILabel *label=(UILabel *)view;
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
             [UIView animateWithDuration:1.f delay:0.02*(label.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
             [label setTextColor:[UIColor clearColor]];
              } completion:^(BOOL finished) {
         
            }];
                 
        });
    }
  }
}
@end
