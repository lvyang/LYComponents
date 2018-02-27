//
//  CCBaseCollectionCell.h
//  CloudCamera
//
//  Created by Yang.Lv on 15/7/20.
//  Copyright (c) 2015年 NetPower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYBaseComponentsProtocol.h"


@interface LYBaseCollectionCell : UICollectionViewCell<LYCellConfigureDelegate>

@property (nonatomic, copy) void(^longPressHandler)(LYBaseCollectionCell *cell);

@end
