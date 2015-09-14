//
//  JSRefreshHeadView.h
//  Refresh
//
//  Created by lvjinsong on 15/8/23.
//  Copyright (c) 2015年 lvjinsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSRefreshHeadView : UIView
{
    UILabel *statusLabel;
    UIActivityIndicatorView *loadingView;
}

@property(nonatomic,readwrite)CGFloat pullSpacing;
@property(nonatomic,readwrite)BOOL isRefreshing;

- (void)finishRefreshing;

@end
