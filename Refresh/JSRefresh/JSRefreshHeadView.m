//
//  JSRefreshHeadView.m
//  Refresh
//
//  Created by lvjinsong on 15/8/23.
//  Copyright (c) 2015年 lvjinsong. All rights reserved.
//

#import "JSRefreshHeadView.h"

@implementation JSRefreshHeadView
{
    UIColor *loadingColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        loadingColor = [UIColor colorWithRed:86/255.0 green:202/255.0 blue:139/255.0 alpha:1.0];
        
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-20, 20, frame.size.width/2+20, frame.size.height-20)];
        statusLabel.textColor = [UIColor grayColor];
        statusLabel.font = [UIFont systemFontOfSize:15];
        statusLabel.text = @"下拉刷新...";
        [self addSubview:statusLabel];
        
        loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.center = statusLabel.center;
        loadingView.color = loadingColor;
        loadingView.hidden = YES;
        [self addSubview:loadingView];
        
        CGRect loadFrame = loadingView.frame;
        loadFrame.origin.x = floor(frame.size.width/2-loadFrame.size.width-40);
        loadingView.frame = loadFrame;
    }
    return self;
}

- (void)setPullSpacing:(CGFloat)spacing
{
    if (spacing != _pullSpacing) {
        _pullSpacing = spacing;
        
        [self setNeedsDisplay];
    }
    
    statusLabel.text = fabs(_pullSpacing) >= self.frame.size.height ? @"松开即可刷新..." : @"下拉刷新...";
}

- (void)setIsRefreshing:(BOOL)refreshing
{
    if (refreshing != _isRefreshing) {
        _isRefreshing = refreshing;
        
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (!_isRefreshing) {
        CGFloat endAngle = fabs(_pullSpacing)/rect.size.height*M_PI*2;
        CGContextAddArc(context, rect.size.width/2-50, rect.size.height/2+10, 15, 0, endAngle, 0);
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, loadingColor.CGColor);
        CGContextStrokePath(context);
    } else {
        CGContextClearRect(context, rect);
        
        statusLabel.text = @"加载中...";
        loadingView.hidden = NO;
        [loadingView startAnimating];
    }
}

- (void)finishRefreshing
{
    _pullSpacing = 0;
    _isRefreshing = NO;
    loadingView.hidden = YES;
    [loadingView stopAnimating];
}

@end
