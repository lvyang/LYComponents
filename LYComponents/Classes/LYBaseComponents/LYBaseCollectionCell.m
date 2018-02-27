//
//  CCBaseCollectionCell.m
//  CloudCamera
//
//  Created by Yang.Lv on 15/7/20.
//  Copyright (c) 2015年 NetPower. All rights reserved.
//

#import "LYBaseCollectionCell.h"

@implementation LYBaseCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [self.contentView addGestureRecognizer:longPress];
    }
    return self;
}

- (void)longPressAction:(id)gesture
{
    if (self.longPressHandler) {
        self.longPressHandler(self);
    }
}

@end
