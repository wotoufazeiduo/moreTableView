//
//  ViewController.m
//  moreTableViewDemo
//
//  Created by hntx on 2020/7/21.
//  Copyright © 2020 CYN. All rights reserved.
//

#import "ViewController.h"
#import "CYNDailyView.h"
#import "CYNWeeklyView.h"
#import "CYNVIPDataView.h"
#import "CYNHeaderView.h"
#import "UIView+CYNXYView.h"

@interface ViewController ()<UIScrollViewDelegate,CYNHeaderViewDelegate>
@property (nonatomic,strong) UIScrollView *mainscrollView;
@property(nonatomic,strong)NSMutableArray *tabelViewArr;
@property(nonatomic,strong)CYNDailyView *dailyView;
@property(nonatomic,strong)CYNWeeklyView *weeklyView;
@property(nonatomic,strong)CYNVIPDataView *vipDataView;
@property(nonatomic,strong)CYNHeaderView *headerView;
@property (nonatomic, assign) CGPoint lastContentOffset;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];


}
-(void)setupUI{
    
    [self.view addSubview:self.mainscrollView];

    [self.mainscrollView addSubview:self.dailyView];
    [self.mainscrollView addSubview:self.weeklyView];
    [self.mainscrollView addSubview:self.vipDataView];
    [self.mainscrollView addSubview:self.headerView];
    
    
    
    
}
#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainscrollView) {
        self.headerView.x = scrollView.contentOffset.x;
        int index = 0;
        
        if (self.lastContentOffset.x < scrollView.contentOffset.x) {
            //往右滑动，向上取整
            index = ceil((scrollView.contentOffset.x/CYNSCREEN_WIDTH));
        }else if (self.lastContentOffset.x > scrollView.contentOffset.x)
        {
            //往左滑动，向下取整
            index = floor((scrollView.contentOffset.x/CYNSCREEN_WIDTH));
        }else
        {
            //没动
            index = (scrollView.contentOffset.x/CYNSCREEN_WIDTH);
        }
        
        CGFloat mobileDistance = (0-self.headerView.y);
        switch (index) {
            case 0:{
                //修改circleTableView
                if (self.dailyView.tableView.contentOffset.y<mobileDistance) {
                    [self.dailyView.tableView setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
                }
            }
                break;
            case 1:{
                //修改photoView
                if (self.weeklyView.tableView.contentOffset.y<mobileDistance) {
                    [self.weeklyView.tableView setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
                }
            }
                break;
            case 2:{
                       //修改photoView
                       if (self.vipDataView.tableView.contentOffset.y<mobileDistance) {
                           [self.vipDataView.tableView setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
                       }
                   }
                       break;
            
                
            default:
                break;

        }
        self.lastContentOffset = scrollView.contentOffset;
    }
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    static int lastIndex = 0;
    int index = 0;

    if (self.lastContentOffset.x < scrollView.contentOffset.x) {
        //往右滑动，向上取整
        index = ceil((scrollView.contentOffset.x/CYNSCREEN_WIDTH));
    }else if (self.lastContentOffset.x > scrollView.contentOffset.x)
    {
        //往左滑动，向下取整
        index = floor((scrollView.contentOffset.x/CYNSCREEN_WIDTH));
    }else
    {
        //没动
        index = (scrollView.contentOffset.x/CYNSCREEN_WIDTH);
    }
//    if (lastIndex != index) {  //让headerView重新设置选中的item
        self.headerView.selectIndex = index;
//    }
    lastIndex = index;
}


#pragma mark - headerViewDelegate
-(void)headerView:(CYNHeaderView *)headerView SelectionIndex:(NSInteger)index{
    //让scrollView滚动到指定位置
    [self.mainscrollView setContentOffset:CGPointMake(self.mainscrollView.width*index, 0) animated:YES];
}


-(CYNHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[CYNHeaderView alloc] initWithFrame:CGRectMake(0, 0, CYNSCREEN_WIDTH, 65)];
        _headerView.delegate = self;
        _headerView.backgroundColor = [UIColor greenColor];
    }
    return _headerView;
}



- (UIScrollView *)mainscrollView{
    if (!_mainscrollView) {
        _mainscrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CYNSCREEN_WIDTH, CYNSCREEN_HEIGHT)];
        _mainscrollView.contentSize = CGSizeMake( 3*CYNSCREEN_WIDTH, 0);//  3*CYNSCREEN_WIDTH  可左右滑动
        _mainscrollView.delegate = self;
        _mainscrollView.pagingEnabled = YES;
        _mainscrollView.showsVerticalScrollIndicator = NO;
        _mainscrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _mainscrollView;
}


- (CYNDailyView *)dailyView{
    if (!_dailyView) {
        _dailyView = [[CYNDailyView alloc]initWithFrame:CGRectMake(0,0, CYNSCREEN_WIDTH, self.mainscrollView.height )];
        _dailyView.headerView = self.headerView;
        
        
    }
    return _dailyView;
}

- (CYNWeeklyView *)weeklyView{
    if (!_weeklyView) {
        _weeklyView = [[CYNWeeklyView alloc]initWithFrame:CGRectMake(CYNSCREEN_WIDTH, 0, CYNSCREEN_WIDTH, self.mainscrollView.height)];
        
             _weeklyView.headerView = self.headerView;
        
    }
    return _weeklyView;
}
- (CYNVIPDataView *)vipDataView{
    if (!_vipDataView) {
        _vipDataView = [[CYNVIPDataView alloc]initWithFrame:CGRectMake(2 * CYNSCREEN_WIDTH, 0, CYNSCREEN_WIDTH, self.mainscrollView.height )];
         _vipDataView.headerView = self.headerView;
        
    }
    return _vipDataView;
}
@end
