//
//  ViewController.m
//  KCBlur
//
//  Created by 张帅 on 16/3/20.
//  Copyright © 2016年 ZhangShuai. All rights reserved.
//

#import "ViewController.h"
#import "KCBlurEffect.h"
@interface ViewController ()<KCBlurEffectDelegate>

@property (nonatomic,strong) UIButton *btn;

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
    [self.view addSubview:self.btn];
    
}

-(UIButton *)btn{
    if(_btn==nil){
        _btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setFrame:CGRectMake(kScreenWidth/2-30.0, kScreenHeight-49.0-60.0, 60.0, 60.0)];
        [_btn setTitle:@"点击" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_btn.layer setBorderWidth:0.5];
        [_btn.layer setBorderColor:[UIColor darkGrayColor].CGColor];
        [_btn.layer setCornerRadius:30.0];
        [_btn.layer setMasksToBounds:YES];
        [_btn setBackgroundColor:[UIColor lightGrayColor]];
        [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

#pragma ------------ envent
-(void)btnClicked{

    KCBlurItem  * addMattersItem =[[KCBlurItem alloc] init];
    [addMattersItem setTitle:@"添加事项"];
    [addMattersItem setIcon:[UIImage imageNamed:@"addMatters"]];

    KCBlurItem *addSchedulesItem=[[KCBlurItem alloc]init];
    [addSchedulesItem setTitle:@"添加日程"];
    [addSchedulesItem setIcon:[UIImage imageNamed:@"addSchedule"]];
    
    KCBlurItem *setupChatItem=[[KCBlurItem alloc]init];
    [setupChatItem setTitle:@"发起会话"];
    [setupChatItem setIcon:[UIImage imageNamed:@"setupChat"]];
    
    KCBlurItem *searchContactsItem=[[KCBlurItem alloc]init];
    [searchContactsItem setTitle:@"查找联系人"];
    [searchContactsItem setIcon:[UIImage imageNamed:@"searchContacts"]];
    
//    KCBlurEffect *menu=[[KCBlurEffect alloc]initWithMenus:@[addMattersItem,addSchedulesItem,setupChatItem,searchContactsItem]];
    KCBlurEffect *menu=[[KCBlurEffect alloc]initWithMenu:@[addMattersItem,addSchedulesItem,setupChatItem,searchContactsItem ] ];
    
    [menu setDelegate:self];
    menu.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [menu setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:menu animated:YES completion:nil];

}


#pragma mark - BlurEffectMenu Delegate
- (void)blurEffectMenuDidTapOnBackground:(KCBlurEffect *)menu{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)blurEffectMenu:(KCBlurEffect *)menu didTapOnItem:(KCBlurItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"item.title:%@",item.title);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
