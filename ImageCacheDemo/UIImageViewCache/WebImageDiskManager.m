//
//  WebImageDiskManager.m
//  MomentsDemo
//
//  Created by 崔宗寅 on 2017/6/17.
//  Copyright © 2017年 崔宗寅. All rights reserved.
//

#import "WebImageDiskManager.h"

static WebImageDiskManager *manager;

@implementation WebImageDiskManager

+ (WebImageDiskManager *) manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WebImageDiskManager alloc] init];
    });
    return manager;
}

- (BOOL) saveToDiskWithImage:(NSData *)imageData withName:(NSString *)imageName {
    
    NSString *strFilePath = [self.strImagePath stringByAppendingString:imageName];
    
    return [[NSFileManager defaultManager] createFileAtPath:strFilePath contents:imageData attributes:nil];
}

- (UIImage *) loadImageFromDiskWithName:(NSString *)imageName {
    NSString *strFilePath = [self.strImagePath stringByAppendingString:imageName];
    
    NSData *imgData = [NSData dataWithContentsOfFile:strFilePath];
    UIImage *image = [UIImage imageWithData:imgData];
    return image;
}


#pragma mark - Lazy loading
- (NSString *) strImagePath {
    if (!_strImagePath) {
        //set default image disk cache path
        _strImagePath = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/WebImageDiskCaches/"];
        
        //Create Image DiskCache Path
        if (![[NSFileManager defaultManager] fileExistsAtPath:_strImagePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_strImagePath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
    }
    return _strImagePath;
}

@end
