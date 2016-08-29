//
//  UALHospitalTableViewController.h
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UALAddHospitalViewController.h"

@interface UALHospitalTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UALAddHospitalViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tabla;

@end
