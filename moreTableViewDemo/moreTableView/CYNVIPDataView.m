//
//  CYNVIPDataView.m
//  moreTableViewDemo
//
//  Created by hntx on 2020/7/21.
//  Copyright © 2020 CYN. All rights reserved.
//

#import "CYNVIPDataView.h"

@interface CYNVIPDataView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) CGPoint lastContentOffset;

@end


@implementation CYNVIPDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.tableView];
        
        
    }
    return self;
}
- (void)setHeaderView:(CYNHeaderView *)headerView{
    
    _headerView = headerView;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headerView.height, 0, 0, 0);
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYNSCREEN_WIDTH, self.headerView.height)];
    self.tableView.tableHeaderView = tableHeaderView;
    [self.tableView reloadData];
    
    
}
#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat placeHolderHeight = self.headerView.height - 44;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    
    
    if (offsetY >= 0 && offsetY <= placeHolderHeight) {
        if (offsetY > self.lastContentOffset.y) {
            //往上滑动
            if (offsetY>(-self.headerView.y)) {
                self.headerView.y = -offsetY;
            }
        }else
        {
            //往下滑动
            if (offsetY<(-self.headerView.y)) {
                self.headerView.y = -offsetY;
            }
        }
    }
    else if (offsetY > placeHolderHeight) {
        if (self.headerView.y != (-placeHolderHeight)) {
            if (offsetY > self.lastContentOffset.y) {
                //往上滑动
                self.headerView.y = self.headerView.y - (scrollView.contentOffset.y-self.lastContentOffset.y);
            }
            if (self.headerView.y < (-placeHolderHeight)) {
                self.headerView.y = -placeHolderHeight;
            }
            if (self.headerView.y>=0) {
                self.headerView.y = 0;
            }
        }
    }
    else if (offsetY <0) {
        self.headerView.y =  - offsetY;
    }
    
//    if (offsetY>50) {
//        self.headerView.navView.transparency = 1;
//    }else
//    {
//        self.headerView.navView.transparency = 0;
//    }
    
    self.lastContentOffset = scrollView.contentOffset;
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vipdatacell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"vipdatacell"];
    }
    cell.textLabel.text =[NSString stringWithFormat:@"测试第%ld行VIPData数据",indexPath.row];
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CYNSCREEN_WIDTH, CYNSCREEN_HEIGHT)];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}
@end
