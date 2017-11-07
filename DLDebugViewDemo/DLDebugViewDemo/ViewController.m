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
    
    DLLog(DLDebugViewInfoMessage, @"here is a message in vc");
    DLLog(DLDebugViewInfoWarning, @"here is a warning in vc");
    DLLog(DLDebugViewInfoError, @"here is a error in vc");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
