//
//  ViewController.m
//  ScrollViewTab
//
//  Created by CityLogistics-PC on 16/9/2.
//  Copyright © 2016年 CityLogistics-PC. All rights reserved.
//

#import "ViewController.h"
#import "TCSlideButton.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) TCSlideButton *slideBtn;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.slideBtn = [[TCSlideButton alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 50)];
    NSArray *btnArray = [NSArray arrayWithObjects:@"按价格",@"按车型",@"按价格", nil];
    [self.slideBtn setButtonWithArray:btnArray];
    [self.view addSubview:self.slideBtn];
    __block ViewController *blockSelf = self;
    
    self.slideBtn.ChooseBtnAtIndex = ^(NSInteger index){
//        [blockSelf.scrollView setContentOffset:CGPointMake(self.view.width*(int)index,0) animated:YES];
        CGFloat x  = index *ScreenW;
        blockSelf.contentScrollView.contentOffset = CGPointMake(x, 0);
        [blockSelf setUpOneChildController:index];
        NSLog(@"%ld",index);
    };
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, ScreenW, ScreenH - 70)];
    [self.view addSubview:self.contentScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(3 * ScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator  = NO;
    self.contentScrollView.delegate = self;
    
    FirstViewController *vc = [[FirstViewController alloc] init];
    [self addChildViewController:vc];
    
    SecondViewController *vc2= [[SecondViewController alloc] init];
    [self addChildViewController:vc2];
    
    ThirdViewController *vc3 = [[ThirdViewController alloc] init];
    [self addChildViewController:vc3];
    
    [self setUpOneChildController:0];
}

-(void)setUpOneChildController:(NSInteger)index{
    
    
    CGFloat x  = index * ScreenW;
    UIViewController *vc  =  self.childViewControllers[index];
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, ScreenW, ScreenH - self.contentScrollView.frame.origin.y);
    [self.contentScrollView addSubview:vc.view];
    
}


#pragma mark - UIScrollView  delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger i  = self.contentScrollView.contentOffset.x / ScreenW;
    [self setUpOneChildController:i];
    [self.slideBtn setIndexChoose:i];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
