//
//  ViewController.m
//  ImageCacheDemo
//
//  Created by 崔宗寅 on 2017/8/8.
//  Copyright © 2017年 崔宗寅. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Cache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initData];
    
    [self initSubviews];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) initData {
    
}

- (void) initSubviews {
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 200, 200)];
    [imgView setBackgroundColor:[UIColor blueColor]];
    [imgView setImageWithUrl:@"http://pic49.nipic.com/file/20140927/19617624_230415502002_2.jpg"];
    [self.view addSubview:imgView];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(imgView.frame.origin.x, imgView.frame.origin.y + imgView.frame.size.height + 50, 200, 200)];
    [imgView2 setBackgroundColor:[UIColor redColor]];
    [imgView2 setImageWithUrl:@"http://pic49.nipic.com/file/20140927/15502002_2.jpg" withPlaceHolder:[UIImage imageNamed:@"placeholder.jpg"]];
    [self.view addSubview:imgView2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
