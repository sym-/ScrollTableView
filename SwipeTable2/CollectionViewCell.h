//
//  CollectionViewCell.h
//  SwipeTable2
//
//  Created by 宋元明 on 16/8/22.
//  Copyright © 2016年 宋元明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellModel.h"
#import "CusTableView.h"
#import "CusWebView.h"

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constaring;


@property (nonatomic, strong) CusTableView *tableView;

@property (nonatomic, strong) CusWebView *webView;


@property (nonatomic, strong) CollectionCellModel *collectionItemModel;

-(void)setCollectionTableItemModel:(CollectionCellModel *)model;

-(void)setCollectionWebItemModel:(CollectionCellModel *)model;


@end
