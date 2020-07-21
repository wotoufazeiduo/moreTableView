//
//  CYNWeeklyView.h
//  moreTableViewDemo
//
//  Created by hntx on 2020/7/21.
//  Copyright © 2020 CYN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CYNHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CYNWeeklyView : UIView
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)CYNHeaderView *headerView;
@end

NS_ASSUME_NONNULL_END
