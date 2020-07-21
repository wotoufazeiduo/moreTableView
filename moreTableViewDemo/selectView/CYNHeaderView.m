//
//  CYNHeaderView.m
//  moreTableViewDemo
//
//  Created by hntx on 2020/7/21.
//  Copyright © 2020 CYN. All rights reserved.
//

#import "CYNHeaderView.h"
#import "CYNSelectTool.h"

@interface CYNHeaderView()

@property (nonatomic, strong) CYNSelectTool *switchView;
@end

@implementation CYNHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    self.switchView.selectIndex = selectIndex;
}

-(void)setupUI{
    
    [self addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_offset(-8);
        make.height.mas_offset(32);
        make.width.mas_offset(160);
    }];
}
-(CYNSelectTool *) switchView{
    if (!_switchView) {
        _switchView = [CYNSelectTool new];
//        _switchView.backgroundColor = [UIColor blueColor];
        _switchView.items = @[@"日报",@"周报",@"VIP数据"];
        __weak typeof(self) weakself = self;
        _switchView.selectionToolBlock = ^(NSInteger index) {
            NSLog(@"%zi",index);
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(headerView:SelectionIndex:)]) {
                [weakself.delegate headerView:weakself SelectionIndex:index];
            }
        };
    }
    return _switchView;
}



@end
