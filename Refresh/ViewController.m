//
//  ViewController.m
//  Refresh
//
//  Created by lvjinsong on 15/8/21.
//  Copyright (c) 2015年 lvjinsong. All rights reserved.
//

#import "ViewController.h"
#import "RefreshTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    RefreshTableView *refreshView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:refreshView];
}



@end
