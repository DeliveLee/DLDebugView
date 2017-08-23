//
//  ViewController.m
//  DLDebugViewDemo
//
//  Created by DeliveLee on 23/08/2017.
//  Copyright © 2017 DeliveLee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.whiteColor;
    
    DLLog(DLDebugViewInfoMessage, @"here is a message");
    DLLog(DLDebugViewInfoWarning, @"here is a warning");
    DLLog(DLDebugViewInfoError, @"here is a error");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
