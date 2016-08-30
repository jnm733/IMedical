//
//  UALViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALViewController.h"

@interface UALViewController ()

@end

@implementation UALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    #ifdef VERSION2
    self.title = @"IMedical V2";
    #elif VERSION1
    self.title = @"IMedical V1";
    #elif VERSION3
    self.title = @"IMedical V3";
    #endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
