//
//  UALHepatitisTableViewController.h
//  IMedical
//
//  Created by Jose Luis on 8/29/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UALAddHepatitisViewController.h"

@interface UALHepatitisTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UALAddHepatitisViewController>



@property (nonatomic, strong) id delegate;
@property (nonatomic) int idPaciente;
@property (nonatomic) NSString* dniPaciente;
@property (strong, nonatomic) IBOutlet UITableView *tabla;



@end
