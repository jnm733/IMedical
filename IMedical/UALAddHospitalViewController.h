//
//  UALAddHospitalViewController.h
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UALAddHospitalViewControllerDelegate
-(void) editionDidFinished;
@end

@interface UALAddHospitalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *capacidadText;
@property (nonatomic, strong) id<UALAddHospitalViewControllerDelegate>
delegate;
@property (nonatomic) int idHospitalEdit;
@property (nonatomic) NSString* nombreHospitalEdit;
@property (nonatomic) NSString* localizacionHospitalEdit;
@property (nonatomic) int capacidadHospitalEdit;





- (IBAction)guardarDatos:(id)sender;

@end
