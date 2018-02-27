//
//  BaseCollectionView.h
//  CloudCamera
//
//  Created by Yang.Lv on 15/7/20.
//  Copyright (c) 2015年 NetPower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYBaseCollectionCell.h"

/* table view cell did selected handler **/
typedef void (^ CollectionViewCellDidSelectedHandler)(UICollectionView *collectionView, NSIndexPath *indexPath, id dataModel);

/*
 * 此类抽离了UICollectionView的一些基本操作
 */
@interface LYBaseCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

/** data source */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 数据源是否有多个section */
@property (nonatomic, assign) BOOL mutilSections;

// call back
@property (nonatomic, copy) CollectionViewCellDidSelectedHandler cellSelectedHandler;

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout cellNibName:(NSString *)nibName;
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout cellClassName:(NSString *)cellClassName;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)allItems;

@end
