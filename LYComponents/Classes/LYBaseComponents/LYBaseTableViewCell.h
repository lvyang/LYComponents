//
//  BaseTableViewCell.h
//  ProcurementApp
//
//  Created by Yang.Lv on 11/24/14.
//  Copyright (c) 2014 PwC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYBaseComponentsProtocol.h"

@interface LYBaseTableViewCell : UITableViewCell<LYCellConfigureDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
