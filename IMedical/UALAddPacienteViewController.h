//
//  UALAddPacienteViewController.h
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UALAddPacienteViewController
-(void) editionDidFinished;
@end

@interface UALAddPacienteViewController : UIViewController

@property (nonatomic, strong) id<UALAddPacienteViewController>
delegate;
@property (nonatomic) int idHospital;
@property (nonatomic) NSString* nombreHospital;

@property (nonatomic) int idPacienteEdit;
@property (nonatomic) NSString* nombrePacienteEdit;
@property (nonatomic) NSString* apellidosPacienteEdit;
@property (nonatomic) NSString* dniPacienteEdit;
@property (nonatomic) NSString* fechaNacimientoPacienteEdit;
@property (nonatomic) NSString* numSegSocialPacienteEdit;



- (IBAction)guardarDatos:(id)sender;


@end
