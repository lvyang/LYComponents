//
//  BaseCollectionView.m
//  CloudCamera
//
//  Created by Yang.Lv on 15/7/20.
//  Copyright (c) 2015年 NetPower. All rights reserved.
//

#import "LYBaseCollectionView.h"

@interface LYBaseCollectionView ()

@property(nonatomic, strong) NSString *cellIdentifier;

@property (nonatomic, copy) void (^refreshHeaderHandler)(void);
@property (nonatomic, copy) void (^refreshFooterHandler)(void);

@end

@implementation LYBaseCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    NSString *reason = @"use initWithFrame:collectionViewLayout:cellNibName: or initWithFrame:collectionViewLayout:cellClassName: to initialize BaseCollectionView";

    @throw [NSException exceptionWithName:@"Init error" reason:reason userInfo:nil];
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout cellNibName:(NSString *)nibName
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.cellIdentifier = nibName;
        [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:self.cellIdentifier];

        self.dataArray = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout cellClassName:(NSString *)cellClassName
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.cellIdentifier = cellClassName;
        [self registerClass:NSClassFromString(cellClassName) forCellWithReuseIdentifier:self.cellIdentifier];

        self.dataArray = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

#pragma mark - public
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mutilSections) {
        return self.dataArray[indexPath.section][indexPath.row];
    }

    return self.dataArray[indexPath.row];
}

- (NSArray *)allItems
{
    NSMutableArray *allItems = [NSMutableArray array];

    if (self.mutilSections) {
        for (NSArray *array in self.dataArray) {
            [allItems addObjectsFromArray:array];
        }

        return allItems;
    }

    return self.dataArray;
}

#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.mutilSections) {
        return self.dataArray.count;
    }

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.mutilSections) {
        return [self.dataArray[section] count];
    }

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYBaseCollectionCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id                  item = [self itemAtIndexPath:indexPath];

    if ([cell respondsToSelector:@selector(configureCellWithModel:atIndexPath:)]) {
        [cell configureCellWithModel:item atIndexPath:indexPath];
    }

    return cell;
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellSelectedHandler) {
        self.cellSelectedHandler(collectionView, indexPath, [self itemAtIndexPath:indexPath]);
    }
}

@end
