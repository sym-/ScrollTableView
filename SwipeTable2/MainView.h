//
//  MainView.h
//  SwipeTable2
//
//  Created by 宋元明 on 16/8/22.
//  Copyright © 2016年 宋元明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentControl.h"

@interface MainView : UIView

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UIView *headerView;

@property (strong, nonatomic) UIImageView *headerImageView;

@property (strong, nonatomic) CustomSegmentControl *segmentControl;

@end
