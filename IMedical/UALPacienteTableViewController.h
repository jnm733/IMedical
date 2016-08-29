//
//  UALPacienteTableViewController.h
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UALAddPacienteViewController.h"

@interface UALPacienteTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UALAddPacienteViewController>


@property (nonatomic, strong) id delegate;
@property (nonatomic) int idHospital;
@property (nonatomic) NSString* nombreHospital;
@property (strong, nonatomic) IBOutlet UITableView *tabla;



@end
