//
//  CYNHeaderView.h
//  moreTableViewDemo
//
//  Created by hntx on 2020/7/21.
//  Copyright © 2020 CYN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class CYNHeaderView;
@protocol CYNHeaderViewDelegate<NSObject>
@required
-(void)headerView:(CYNHeaderView *)headerView SelectionIndex:(NSInteger)index;

@end


@interface CYNHeaderView : UIView
@property (nonatomic,weak) id<CYNHeaderViewDelegate> delegate;
@property (nonatomic, assign) NSInteger selectIndex;
@end

NS_ASSUME_NONNULL_END
