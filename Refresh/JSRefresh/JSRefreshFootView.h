//
//  JSRefreshFootView.h
//  Refresh
//
//  Created by lvjinsong on 15/8/23.
//  Copyright (c) 2015年 lvjinsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSRefreshFootView : UIView
{
    UIActivityIndicatorView *loadingView;
}

@property(nonatomic,readwrite)BOOL isLoading;

@end
