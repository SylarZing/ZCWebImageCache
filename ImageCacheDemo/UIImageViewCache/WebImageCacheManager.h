//
//  WebImageCacheManager.h
//  MomentsDemo
//
//  Created by 崔宗寅 on 2017/6/17.
//  Copyright © 2017年 崔宗寅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebImageCacheManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *dicImage;

+ (WebImageCacheManager *)manager;

- (void) saveToCacheWithImage:(UIImage *)image withName:(NSString *)name;

- (UIImage *) loadImageFromCacheWithName: (NSString *)name;

@end
