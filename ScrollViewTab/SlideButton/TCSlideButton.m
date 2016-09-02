//
//  TCSlideButton.m
//  CarRentalApp
//
//  Created by mac on 16/8/11.
//  Copyright © 2016年 DryenSiu. All rights reserved.
//

#import "TCSlideButton.h"
#import "UIView+Extension.h"
#define TCColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface TCSlideButton()

@property (weak,nonatomic)UIButton *selectBtn;
@property (strong,nonatomic)UIView *underline;
@property (strong,nonatomic) NSArray *bottonArray;
@end

@implementation TCSlideButton


-(void)setButtonWithArray:(NSArray *)btnArray{

    _bottonArray = btnArray;
    for (int i = 0; i<btnArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*self.width/btnArray.count+i, 0, self.width/btnArray.count-1, 47)];
        [btn setTitle:[btnArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btn setTitleColor:TCColor(48, 48, 48) forState:UIControlStateNormal];
        [btn setTag:i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 1) {
            _selectBtn = btn;
        }
        if (i != btnArray.count-1) {
            UIView *sep = [[UIView alloc] initWithFrame:CGRectMake((i+1)*self.width/btnArray.count, 0, 1, 47)];
            sep.backgroundColor = TCColor(240, 240, 240);
            [self addSubview:sep];
        }
    }
    
    self.underline = [[UIView alloc] initWithFrame:CGRectMake(0, 48, self.width/btnArray.count, 2)];
    self.underline.backgroundColor = TCColor(13, 61, 110);
    [self addSubview:self.underline];
    
}

-(void)btnClick:(UIButton *)btn{
    _selectBtn = btn;
    [UIView animateWithDuration:0.3 animations:^{
        self.underline.centerX = _selectBtn.centerX;
    }];
    if (self.ChooseBtnAtIndex) {
        self.ChooseBtnAtIndex(btn.tag);
    };
}

- (void)setIndexChoose:(NSInteger)indexChoose
{
    [UIView animateWithDuration:0.3 animations:^{
         self.underline.frame = CGRectMake(self.width * indexChoose/_bottonArray.count , 48, self.width/_bottonArray.count, 2);
    }];
}
@end
