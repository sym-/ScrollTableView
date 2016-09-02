//
//  MainView.m
//  SwipeTable2
//
//  Created by 宋元明 on 16/8/22.
//  Copyright © 2016年 宋元明. All rights reserved.
//

#import "MainView.h"
#import "UIView+STFrame.h"
#import "CollectionViewCell.h"
#import "CollectionCellModel.h"

static NSString * const SwipeContentViewCellIdfy       = @"SwipeContentViewCellIdfy";
static const void *SwipeTableViewItemTopInsetKey       = &SwipeTableViewItemTopInsetKey;
static void * SwipeTableViewItemContentOffsetContext   = &SwipeTableViewItemContentOffsetContext;
static void * SwipeTableViewItemContentSizeContext     = &SwipeTableViewItemContentSizeContext;
static void * SwipeTableViewItemPanGestureContext      = &SwipeTableViewItemPanGestureContext;

static CGFloat SegmentHeight = 44;

#define RTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RTRandomColor RTColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface MainView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImage *img;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, assign) CGFloat barMinInset;

@property (nonatomic, assign) CGFloat headerInset;

@property (nonatomic, assign) CGFloat currentOffSet;

@property (nonatomic, strong) UIScrollView *shouldVisibleItemView;


@end

@implementation MainView

-(void)awakeFromNib{
    [super awakeFromNib];

    self.barMinInset = 44;
    self.currentOffSet = 0;
    
    
    
    [self setupUI];
}

-(void)setupUI{
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"TTReleaseLabelCollectionViewCell"];
    
    self.img = [UIImage imageNamed:@"IMG_0668.JPG"];
    self.headerImageView = [[UIImageView alloc] initWithImage:self.img];
    self.segmentControl = [[CustomSegmentControl alloc] initWithItems:@[@"item1",@"item2",@"webItem"]];
    
    __weak typeof(self)weakSelf = self;
    self.segmentControl.IndexChangeBlock = ^(NSInteger index){
        UICollectionViewCell * cell = [[weakSelf.collectionView visibleCells] firstObject];
        NSIndexPath *indexPath = [weakSelf.collectionView indexPathForCell:cell];
        if (index != indexPath.item) {
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
        
    };
    
    [self addSubview:self.collectionView];
    [self addSubview:self.headerImageView];
    [self addSubview:self.segmentControl];
    
 }

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        self.layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.sectionInset = UIEdgeInsetsZero;
        _layout.itemSize = [UIScreen mainScreen].bounds.size;
    }
    return _layout;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    
    self.headerImageView.frame = CGRectMake(0, 0, KWidth, self.img.size.height*KWidth/self.img.size.width);
    self.segmentControl.frame = CGRectMake(0, CGRectGetMaxY(self.headerImageView.frame), KWidth, SegmentHeight);
    
    self.headerInset = CGRectGetMaxY(self.segmentControl.frame);
    self.currentOffSet = -self.headerInset;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"TTReleaseLabelCollectionViewCell";
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = RTRandomColor;
    CollectionCellModel *model = [[CollectionCellModel alloc] init];
    model.index = indexPath.item;
    model.tableViewInsetTop = self.headerInset;
    model.tableViewOffSet = self.currentOffSet;
    if (indexPath.item == 0) {
        model.collectionItemTableData = @(5);
        [cell setCollectionTableItemModel:model];

    }
    else if(indexPath.item == 1){
        model.collectionItemTableData = @(20);
        [cell setCollectionTableItemModel:model];

    }
    else if (indexPath.item == 2){
        model.urlStr = @"http://cool.qctt.cn/html/mobile/newsinfo?id=73580&userid=&hiddenTag=1/hiddenTag/1";
        [cell setCollectionWebItemModel:model];
    }
   
    
    [_shouldVisibleItemView removeObserver:self forKeyPath:@"contentOffset"];
    [_shouldVisibleItemView removeObserver:self forKeyPath:@"contentSize"];
    [_shouldVisibleItemView removeObserver:self forKeyPath:@"panGestureRecognizer.state"];
    if (indexPath.item == 2) {
        self.shouldVisibleItemView  = cell.webView;
    }
    else{
        self.shouldVisibleItemView  = cell.tableView;
    }
    
    [_shouldVisibleItemView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:SwipeTableViewItemContentOffsetContext];
    [_shouldVisibleItemView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:SwipeTableViewItemContentSizeContext];
    [_shouldVisibleItemView addObserver:self forKeyPath:@"panGestureRecognizer.state" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:SwipeTableViewItemPanGestureContext];
    
    return cell;
}


#pragma mark - observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    /** contentOffset */
    if (context == SwipeTableViewItemContentOffsetContext) {
        CGFloat newOffsetY      = [change[NSKeyValueChangeNewKey] CGPointValue].y;
        if (newOffsetY < - self.barMinInset) {
            self.segmentControl.st_bottom  = - newOffsetY;
            self.headerImageView.st_bottom = self.segmentControl.st_top;

        }else {
            self.segmentControl.st_bottom  = self.barMinInset;
            // 'fmax' is used to fix the bug below iOS8.3 : the position of the bar will not correct when the swipeHeaderView is outside of the screen.
            self.headerImageView.st_bottom = fmax(- (newOffsetY + self.barMinInset), 0);
        }
        
        self.currentOffSet = newOffsetY;
        
    }
    /** contentSize */
    else if (context == SwipeTableViewItemContentSizeContext) {
//        CGSize newSize      = [change[NSKeyValueChangeNewKey] CGSizeValue];
//        UIScrollView * scrollView = object;
//        CGSize minRequireSize     = scrollView.contentSize;
//        _shouldVisibleItemView.contentSize = newSize;
    }
    /** panGestureRecognizer */
    else if (context == SwipeTableViewItemPanGestureContext) {
        UIGestureRecognizerState state = (UIGestureRecognizerState)[change[NSKeyValueChangeNewKey] integerValue];
        switch (state) {
            case UIGestureRecognizerStateBegan:
            {

            }
                break;
            default:
                break;
        }
    }
}

















//#pragma mark UICollectionViewDelegateFlowLayout
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsZero;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return self.bounds.size;
//}






@end
