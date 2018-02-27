//
//  BaseTableiView.m
//  KaoWaXiu
//
//  Created by Yang.Lv on 8/18/14.
//  Copyright (c) 2014 Kaowaxiu. All rights reserved.
//

#import "LYBaseTableView.h"

@interface LYBaseTableView ()


@property(nonatomic, copy)  NSString *cellIdentifier;

@property (nonatomic, copy) void(^refreshHeaderHandler)();

@end

@implementation LYBaseTableView

- (id)initWithFrame:(CGRect)frame
              style:(UITableViewStyle)style
          cellNibClass:(NSString *)classString
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.items = [NSMutableArray array];
        self.cellIdentifier = classString;
        [self registerNib:[UINib nibWithNibName:classString bundle:nil] forCellReuseIdentifier:self.cellIdentifier];
        
        self.delegate = self;
        self.dataSource = self;
        
        [self initialize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
              style:(UITableViewStyle)style
          cellClass:(NSString *)classString
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.items = [NSMutableArray array];
        self.cellIdentifier = classString;
        [self registerClass:NSClassFromString(classString) forCellReuseIdentifier:self.cellIdentifier];
        
        self.delegate = self;
        self.dataSource = self;
        
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    // 在此做额外初始化操作
}
- (NSArray *)allItems
{
    if (!self.multiSections) {
        return self.items;
    }
    
    NSMutableArray *allItems = [NSMutableArray array];
    for (NSArray *items in self.items) {
        [allItems addObjectsFromArray:items];
    }
    
    return allItems;
}

#pragma mark - public
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.multiSections) {
        return self.items[indexPath.section][indexPath.row];
    }
    
    return self.items[indexPath.row];
}

- (void)tableViewWillConfigureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withModel:(id)model
{
    // 子类实现
}

#pragma mark - UITableViewDataSource method
/** @override */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.multiSections) {
        return self.items.count;
    }
    
    return 1;
}

/** @override */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.multiSections) {
        return [self.items[section] count];
    }
    
    return self.items.count;
}

/** @override */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYBaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id  item = [self itemAtIndexPath:indexPath];
    
    [self tableViewWillConfigureCell:cell atIndexPath:indexPath withModel:item];
    
    if ([cell respondsToSelector:@selector(configureCellWithModel:atIndexPath:)]) {
        [cell configureCellWithModel:item  atIndexPath:indexPath];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate method
/** @override */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellSelectedHandler) {
        self.cellSelectedHandler(tableView, indexPath, [self itemAtIndexPath:indexPath]);
    }
}

/** @override */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellDeselectedHandler) {
        self.cellDeselectedHandler(tableView, indexPath, [self itemAtIndexPath:indexPath]);
    }
}

/** @override */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:self.separatorInset];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:self.separatorInset];
    }
}


@end
