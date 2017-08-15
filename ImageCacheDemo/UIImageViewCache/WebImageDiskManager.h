//
//  WebImageDiskManager.h
//  MomentsDemo
//
//  Created by 崔宗寅 on 2017/6/17.
//  Copyright © 2017年 崔宗寅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebImageDiskManager : NSObject

@property (nonatomic, strong) NSString *strImagePath;

+ (WebImageDiskManager *) manager;

- (BOOL) saveToDiskWithImage:(NSData *)imageData withName:(NSString *)imageName;

- (UIImage *) loadImageFromDiskWithName: (NSString *)imageName;

@end
