# JSPullingRefresh
很方便的集成UITableView和UICollectionView的快速集成下拉刷新和上拉加载功能

Example

refreshView = [[JSRefreshView alloc] initWithFrame:myTableView.frame ScrollView:myTableView Delegate:self];

delegate

- (void)refreshView:(JSRefreshView *)view WithState:(JSRefreshStates)state
{
    switch (state) {
        case JSRefreshStateDropPulling: {
            //下拉刷新
        }
            break;
            
        case JSRefreshStateUpLoadPulling: {
            //上拉加载
        }
            break;
            
        default:
            break;
    }
}



