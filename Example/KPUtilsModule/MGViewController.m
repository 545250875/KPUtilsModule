//
//  MGViewController.m
//  KPUtilsModule
//
//  Created by wuchengmiao on 04/28/2019.
//  Copyright (c) 2019 wuchengmiao. All rights reserved.
//

#import "MGViewController.h"
#import "UIView+Toast.h"
#import "ProgressHUDManager.h"


@interface MGViewController ()

@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [ProgressHUDManager showImageError:@"哇哈哈哈"];
    
}



@end
