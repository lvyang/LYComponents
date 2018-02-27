//
//  BaseTableiView.h
//  KaoWaXiu
//
//  Created by Yang.Lv on 8/18/14.
//  Copyright (c) 2014 Kaowaxiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYBaseTableViewCell.h"

/* table view cell configure handler **/
typedef void (^     TableViewCellConfigureBlock)(id cell, id item);
/* table view cell did selected handler **/
typedef void (^     TableViewCellDidSelectedHandler)(UITableView *tableView, NSIndexPath *indexPath, id dataModel);


@interface LYBaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

/* table view's data source **/
@property(nonatomic, strong) NSMutableArray *items;

/*
 *  a boolean indicate whether the table view has muti-sections
 *  YES:tableview has muti-section,and the items must be a two-dimensional array,
 *  NO : tableview has only one section
 */
@property(nonatomic, assign) BOOL multiSections;

// call back
@property(nonatomic, copy) TableViewCellDidSelectedHandler  cellSelectedHandler;
@property(nonatomic, copy) TableViewCellDidSelectedHandler  cellDeselectedHandler;


/**
 *  @description:BaseTableView's initial method. NOTE:You should always use this method to init tableview
 *
 *  @param frame               : tableview's frame;
 *  @param style               : tableview's style;
 *  @param classString         : cell's nib class string;
 *
 *  @return an instance of TableViewDatasourceAndDelegate
 */
- (id)initWithFrame:(CGRect)frame
              style:(UITableViewStyle)style
       cellNibClass:(NSString *)classString;

/**
 *  @description:BaseTableView's initial method. NOTE:You should always use this method to init tableview
 *
 *  @param frame               : tableview's frame;
 *  @param style               : tableview's style;
 *  @param classString         : cell's  class string;
 *
 *  @return an instance of TableViewDatasourceAndDelegate
 */
- (id)initWithFrame:(CGRect)frame
              style:(UITableViewStyle)style
          cellClass:(NSString *)classString;

/**
 *  @description: 在此方法里做额外的初始化操作
 */
- (void)initialize;

- (NSArray *)allItems;

/*
 *  get object in items at indexPath
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableViewWillConfigureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withModel:(id)model;

@end
