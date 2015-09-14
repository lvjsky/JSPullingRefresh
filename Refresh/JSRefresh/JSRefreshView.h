//
//  JSRefreshView.h
//  Refresh
//
//  Created by lvjinsong on 15/8/21.
//  Copyright (c) 2015年 lvjinsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSRefreshHeadView.h"
#import "JSRefreshFootView.h"

typedef NS_ENUM(NSInteger, JSRefreshStates)
{
    JSRefreshStateNormal,           //普通状态
    JSRefreshStateDropPulling,      //下拉刷新
    JSRefreshStateUpLoadPulling,    //上拉加载
};

@class JSRefreshView;
@protocol JSRefreshViewDelegate <NSObject>

- (void)refreshView:(JSRefreshView *)view WithState:(JSRefreshStates)state;

@end

@interface JSRefreshView : UIView

@property(nonatomic,weak)id<JSRefreshViewDelegate>delegate_;

- (instancetype)initWithFrame:(CGRect)frame ScrollView:(UIScrollView *)scrollView Delegate:(id<JSRefreshViewDelegate>)delegate;

//刷新结束
- (void)recoveryPulling;

@end
