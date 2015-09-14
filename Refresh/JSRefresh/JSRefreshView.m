//
//  JSRefreshView.m
//  Refresh
//
//  Created by lvjinsong on 15/8/21.
//  Copyright (c) 2015年 lvjinsong. All rights reserved.
//

#import "JSRefreshView.h"

static NSString *JSRefreshContentOffset = @"contentOffset";
static CGFloat PullHeight               = 60;

@interface JSRefreshView ()
{
    JSRefreshHeadView *headView;
    JSRefreshFootView *footView;
    JSRefreshStates currentRefreshState;
    BOOL isPulling;
}

@property(nonatomic,readonly)UIScrollView *myScrollView;

@end


@implementation JSRefreshView

- (instancetype)initWithFrame:(CGRect)frame ScrollView:(UIScrollView *)scrollView Delegate:(id<JSRefreshViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate_ = delegate;
        currentRefreshState = JSRefreshStateNormal;
        
        _myScrollView = scrollView;
        
        [_myScrollView addObserver:self forKeyPath:JSRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        
        headView = [[JSRefreshHeadView alloc] initWithFrame:CGRectMake(0, -PullHeight, _myScrollView.frame.size.width, PullHeight)];
        [_myScrollView addSubview:headView];
        
        footView = [[JSRefreshFootView alloc] initWithFrame:CGRectMake(0, _myScrollView.frame.size.height, _myScrollView.frame.size.width, PullHeight)];
        [_myScrollView addSubview:footView];
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:JSRefreshContentOffset]) return;
    
    if (isPulling) return;

    CGFloat offsetY = _myScrollView.contentOffset.y;
    if (offsetY == 0) return;
    
    if (_myScrollView.contentInset.bottom == 0 && offsetY > 0) {
        
        [self adjustFootView];
    }
    
    //拖动中
    if (_myScrollView.isDragging) {
        
        if (offsetY < 0) {
            //NSLog(@"%f",offsetY);
            currentRefreshState = (offsetY <= -PullHeight ? JSRefreshStateDropPulling : JSRefreshStateNormal);
            headView.pullSpacing = offsetY;
            
        } else {
            float yMain = _myScrollView.contentSize.height > _myScrollView.frame.size.height ? offsetY + _myScrollView.frame.size.height - _myScrollView.contentSize.height
                                                                                                     : offsetY;
            //NSLog(@"%f",yMain);
            currentRefreshState = (yMain >= PullHeight ? JSRefreshStateUpLoadPulling : JSRefreshStateNormal);
        }
    } else {
        if (currentRefreshState != JSRefreshStateNormal && !isPulling) {
            [self handWithRefreshState];
        }
    }
}

//处理各个状态
- (void)handWithRefreshState
{
    switch (currentRefreshState) {
        case JSRefreshStateDropPulling: {
            NSLog(@"下拉刷新中");
            isPulling = YES;
            headView.isRefreshing = YES;
            
            [UIView animateWithDuration:.3
                             animations:^{
                                 _myScrollView.contentInset = UIEdgeInsetsMake(PullHeight, 0, 0, 0);
                             }];
            
            if ([self.delegate_ respondsToSelector:@selector(refreshView:WithState:)]) {
                [self.delegate_ refreshView:self WithState:currentRefreshState];
            }
        }
            break;
            
        case JSRefreshStateUpLoadPulling: {
            NSLog(@"上拉加载中");
            isPulling = YES;
            footView.isLoading = YES;
        
            [UIView animateWithDuration:.3
                             animations:^{
                                 if (_myScrollView.contentSize.height > _myScrollView.frame.size.height) {
                                     _myScrollView.contentInset = UIEdgeInsetsMake(0, 0, PullHeight, 0);
                                 } else {
                                     _myScrollView.contentInset = UIEdgeInsetsMake(-PullHeight, 0, 0, 0);
                                 }
                             }];
            
            if ([self.delegate_ respondsToSelector:@selector(refreshView:WithState:)]) {
                [self.delegate_ refreshView:self WithState:currentRefreshState];
            }
        }
            break;
            
        case JSRefreshStateNormal: {
           // NSLog(@"普通状态");
        }
            break;
            
        default:
            break;
    }
}

- (void)recoveryPulling
{
    [UIView animateKeyframesWithDuration:.3
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  _myScrollView.contentInset = UIEdgeInsetsZero;
                                  
                             }completion:^(BOOL finished) {
                                  
                                  if (currentRefreshState == JSRefreshStateUpLoadPulling) {
                                      [self adjustFootView];
                                      footView.isLoading = NO;
                                      
                                  } else {
                                      [headView finishRefreshing];
                                  }
                                  
                                  isPulling = NO;
                                  currentRefreshState = JSRefreshStateNormal;
                              }];
}

- (void)adjustFootView
{
    CGRect frame = footView.frame;
    CGSize contentSize = _myScrollView.contentSize;
    CGFloat insetY = _myScrollView.contentInset.bottom;
    frame.origin.y = contentSize.height < _myScrollView.frame.size.height ? _myScrollView.frame.size.height + insetY : contentSize.height + insetY;
    footView.frame = frame;
}

- (void)dealloc
{
    [_myScrollView removeObserver:self forKeyPath:JSRefreshContentOffset context:nil];
}

@end
