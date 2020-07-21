//
//  CYNSelectTool.m
//  moreTableViewDemo
//
//  Created by hntx on 2020/7/21.
//  Copyright © 2020 CYN. All rights reserved.
//

#import "CYNSelectTool.h"



@interface CYNSelectTool ()

@property (nonatomic, strong) NSMutableArray *itemsList;

@end

@implementation CYNSelectTool

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}



-(NSMutableArray *)itemsList{
    if (!_itemsList) {
        _itemsList = [NSMutableArray array];
    }
    return _itemsList;
}


-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    UIButton *item = [self.itemsList objectAtIndex:selectIndex];
    if (item) {
        [self itemClick:item];
    }else{
        [self itemClick:self.itemsList.firstObject];
    }
}

-(void)setItems:(NSArray *)items{
    _items = items;
//    CGFloat width = CYNSCREEN_WIDTH/(items.count *1.0);
    CGFloat width = 47;
    CGFloat height = 32;
    UIButton *last = nil;
    for (int i = 0; i < items.count; i ++) {
        UIButton *item = [UIButton new];
        item.titleLabel.font = [UIFont systemFontOfSize:14];
        [item setTitle:items[i] forState:UIControlStateNormal];
        
        [item setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [item setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        
        item.layer.borderWidth = 1;
        item.layer.cornerRadius = 5;
        
        item.layer.borderColor = [UIColor grayColor].CGColor ;
        
        if (i == 2) {
            width = 68;
        }
        
        if (i == 0) {
               item.selected = YES;
               item.layer.borderColor = [UIColor blueColor].CGColor;
               item.layer.borderWidth = 1;
               
           }

        [self addSubview:item];
        [self.itemsList addObject:item];
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        item.tag = i + 7200942;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.centerY.mas_equalTo(self);
            if (last) {
                make.left.mas_equalTo(last.mas_right);
            }else{
                make.left.mas_offset(0);
            }
        }];
        
 
   
        last = item;
    }
}

-(void)itemClick:(UIButton *)sender{
    
    for (NSInteger i = 0; i < 3; ++i) {
        if (sender.tag == 7200942 + i) {
            sender.selected = YES;
            sender.layer.borderColor = [UIColor blueColor].CGColor;
            sender.layer.borderWidth = 1;
            continue;
            
        }
        
        UIButton *btn = (UIButton *)[self viewWithTag:i + 7200942 ];
        btn.selected = NO;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.borderWidth = 1;
        
        
          
        
    }
    
    if (self.selectionToolBlock) {
        self.selectionToolBlock(sender.tag - 7200942);
    }
    
    
    
    
}
@end
