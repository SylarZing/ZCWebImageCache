//
//  UIImageView+Cache.m
//  MomentsDemo
//
//  Created by 崔宗寅 on 2017/6/17.
//  Copyright © 2017年 崔宗寅. All rights reserved.
//

#import "UIImageView+Cache.h"
#import "WebImageCacheManager.h"
#import "WebImageDiskManager.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation UIImageView (Cache)

- (void) setImageWithUrl:(NSString *)strUrl {
    
    NSString *strImageName = [self md5:strUrl];
    
    UIImage *imgFromCache = [[WebImageCacheManager manager] loadImageFromCacheWithName:strImageName];
    if (imgFromCache) {
        [self setImage:imgFromCache];
        return;
    }
    
    UIImage *imgFromDisk = [[WebImageDiskManager manager] loadImageFromDiskWithName:strImageName];
    if (imgFromDisk) {
        [self setImage:imgFromDisk];
        //save image into cache
        [[WebImageCacheManager manager] saveToCacheWithImage:imgFromDisk withName:strImageName];
        return;
    }
    
    dispatch_queue_t download_queue = dispatch_queue_create("download queue", DISPATCH_QUEUE_SERIAL);
    __weak __typeof(self) weakSelf = self;
    dispatch_async(download_queue, ^{
        __strong __typeof(self) strongSelf = weakSelf;
        
        NSURL *url = [NSURL URLWithString:strUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        if (image == nil) {
            return;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf setImage:image];
                [[WebImageCacheManager manager] saveToCacheWithImage:image withName:strImageName];
                [[WebImageDiskManager manager] saveToDiskWithImage:data withName:strImageName];
            });
        }
        
    });
}

- (void) setImageWithUrl:(NSString *)strUrl withPlaceHolder: (UIImage *)imgPlaceHolder {
    if (imgPlaceHolder == nil) {
        
    } else {
        [self setImage:imgPlaceHolder];
    }
    
    NSString *strImageName = [self md5:strUrl];
    
    UIImage *imgFromCache = [[WebImageCacheManager manager] loadImageFromCacheWithName:strImageName];
    if (imgFromCache) {
        [self setImage:imgFromCache];
        return;
    }
    
    UIImage *imgFromDisk = [[WebImageDiskManager manager] loadImageFromDiskWithName:strImageName];
    if (imgFromDisk) {
        [self setImage:imgFromDisk];
        //save image into cache
        [[WebImageCacheManager manager] saveToCacheWithImage:imgFromDisk withName:strImageName];
        return;
    }
    
    dispatch_queue_t download_queue = dispatch_queue_create("download queue", DISPATCH_QUEUE_SERIAL);
    __weak __typeof(self) weakSelf = self;
    dispatch_async(download_queue, ^{
        __strong __typeof(self) strongSelf = weakSelf;
        
        NSURL *url = [NSURL URLWithString:strUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        if (image == nil) {
            [self setImage:imgPlaceHolder];
            return;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf setImage:image];
                [[WebImageCacheManager manager] saveToCacheWithImage:image withName:strImageName];
                [[WebImageDiskManager manager] saveToDiskWithImage:data withName:strImageName];
            });
        }
        
    });
}

#pragma mark - Private Method
//MD5 encoding
- (NSString *)md5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char schemes[CC_MD5_DIGEST_LENGTH];
    
    //MD5 encoding
    CC_MD5(cStr, (UInt32)strlen(cStr), schemes);
    
    NSMutableString *md5Str = [[NSMutableString alloc] init];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [md5Str appendFormat:@"%02x",schemes[i]];
    }
    
    return md5Str;
}

@end
