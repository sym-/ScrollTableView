//
//  CollectionCellModel.h
//  SwipeTable2
//
//  Created by 宋元明 on 16/8/23.
//  Copyright © 2016年 宋元明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionCellModel : NSObject

@property (nonatomic, strong) NSNumber *collectionItemTableData;

@property (nonatomic, assign)  NSInteger index;

@property (nonatomic, assign) float tableViewInsetTop;

@property (nonatomic, assign) float tableViewOffSet;


@property (nonatomic, strong) NSString *urlStr;


@end
