//
//  PlaceholderTextView.h
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  创建一个有placeHolder的TextView
 */
@interface LYPlaceholderTextView : UITextView

//  textView的默认填充的文字
@property (nonatomic, strong) NSString *placeholder;

//  textView默认填充文字的颜色
@property (nonatomic, strong) UIColor *placeHolderColor;

@end
