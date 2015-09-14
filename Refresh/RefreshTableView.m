//
//  RefreshTableView.m
//  Refresh
//
//  Created by lvjinsong on 15/8/23.
//  Copyright (c) 2015年 lvjinsong. All rights reserved.
//

#import "RefreshTableView.h"

@implementation RefreshTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        currentPage = 1;
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        [self addSubview:myTableView];
        
        refreshView = [[JSRefreshView alloc] initWithFrame:myTableView.frame ScrollView:myTableView Delegate:self];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20*currentPage;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Iden = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Iden];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"刷新测试%ld行",(long)indexPath.row];
    return cell;
}

- (void)refreshView:(JSRefreshView *)view WithState:(JSRefreshStates)state
{
    switch (state) {
        case JSRefreshStateDropPulling: {
            currentPage = 1;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [myTableView reloadData];
                [view recoveryPulling];
            });
        }
            break;
            
        case JSRefreshStateUpLoadPulling: {
            currentPage ++;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [myTableView reloadData];
                [view recoveryPulling];
            });
        }
            break;
            
        default:
            break;
    }
}

@end
