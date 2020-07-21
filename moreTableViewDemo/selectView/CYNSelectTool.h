//
//  CYNSelectTool.h
//  moreTableViewDemo
//
//  Created by hntx on 2020/7/21.
//  Copyright © 2020 CYN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYNSelectTool : UIView
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) void (^selectionToolBlock)(NSInteger index);
@property (nonatomic, assign) NSInteger selectIndex;
@end

NS_ASSUME_NONNULL_END
