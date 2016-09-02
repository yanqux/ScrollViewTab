//
//  TCSlideButton.h
//  CarRentalApp
//
//  Created by mac on 16/8/11.
//  Copyright © 2016年 DryenSiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCSlideButton : UIView

-(void)setButtonWithArray:(NSArray *)btnArray;

@property (copy,nonatomic) void (^ChooseBtnAtIndex)(NSInteger);
@property (nonatomic,assign) NSInteger indexChoose;
@end
