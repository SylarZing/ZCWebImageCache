//
//  WebImageCacheManager.m
//  MomentsDemo
//
//  Created by 崔宗寅 on 2017/6/17.
//  Copyright © 2017年 崔宗寅. All rights reserved.
//

#import "WebImageCacheManager.h"

static WebImageCacheManager *manager;

@implementation WebImageCacheManager

+ (WebImageCacheManager *) manager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WebImageCacheManager alloc] init];
    });
    
    return manager;
}

- (void) saveToCacheWithImage:(UIImage *)image withName:(NSString *)name {
    [self.dicImage setObject:image forKey:name];
}

- (UIImage *) loadImageFromCacheWithName:(NSString *)name {
    UIImage *image = [self.dicImage objectForKey:name];
    return image;
}


#pragma mark - Lazy loading
- (NSMutableDictionary *)dicImage {
    if (_dicImage == nil) {
        _dicImage = [NSMutableDictionary dictionary];
    }
    return _dicImage;
}

@end
