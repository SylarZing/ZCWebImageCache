//
//  UIImageView+Cache.h
//  MomentsDemo
//
//  Created by 崔宗寅 on 2017/6/17.
//  Copyright © 2017年 崔宗寅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Cache)

- (void) setImageWithUrl: (NSString *)strUrl;

- (void) setImageWithUrl:(NSString *)strUrl withPlaceHolder: (UIImage *)imgPlaceHolder;

@end
