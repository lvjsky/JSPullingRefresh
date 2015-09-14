//
//  JSRefreshFootView.m
//  Refresh
//
//  Created by lvjinsong on 15/8/23.
//  Copyright (c) 2015年 lvjinsong. All rights reserved.
//

#import "JSRefreshFootView.h"

@implementation JSRefreshFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-20, 20, frame.size.width/2, 20)];
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = @"加载更多...";
        [self addSubview:titleLabel];
        
        loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.center = titleLabel.center;
        [self addSubview:loadingView];
        
        CGRect loadFrame = loadingView.frame;
        loadFrame.origin.x = floor(frame.size.width/2-loadFrame.size.width-40);
        loadingView.frame = loadFrame;
        
        loadingView.hidden = YES;
    }
    return self;
}

- (void)setIsLoading:(BOOL)loading
{
    if (loading != _isLoading) {
        _isLoading = loading;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    if (_isLoading) {
        loadingView.hidden = NO;
        [loadingView startAnimating];
    } else {
        loadingView.hidden = YES;
        [loadingView stopAnimating];
    }
}



@end
