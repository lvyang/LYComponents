//
//  BSBaseComponentsProtocol.h
//  Pods
//
//  Created by Yang.Lv on 2017/3/1.
//
//

#import <Foundation/Foundation.h>

@protocol LYCellConfigureDelegate <NSObject>

@optional
- (void)configureCellWithModel:(id)aModel atIndexPath:(NSIndexPath *)indexPath;

@end
