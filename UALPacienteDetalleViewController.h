//
//  UALPacienteDetalleViewController.h
//  IMedical
//
//  Created by Jose Luis on 8/28/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UALPacienteDetalleViewController : UIViewController

@property (nonatomic) int idHospital;
@property (nonatomic) NSString* nombreHospital;

@property (nonatomic) int idPaciente;
@property (nonatomic) NSString* nombrePaciente;
@property (nonatomic) NSString* apellidosPaciente;
@property (nonatomic) NSString* dniPaciente;
@property (nonatomic) NSString* fechaNacimientoPaciente;
@property (nonatomic) NSString* numSegSocialPaciente;
@property (nonatomic) NSString* imagenPaciente;


@end
