//
//  RefreshTableView.h
//  Refresh
//
//  Created by lvjinsong on 15/8/23.
//  Copyright (c) 2015年 lvjinsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSRefreshView.h"

@interface RefreshTableView : UIView <UITableViewDelegate,UITableViewDataSource,JSRefreshViewDelegate>
{
    UITableView *myTableView;
    JSRefreshView *refreshView;
    NSInteger currentPage;
}

@end
