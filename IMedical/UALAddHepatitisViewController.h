//
//  UALAddHepatitisViewController.h
//  IMedical
//
//  Created by Jose Luis on 8/29/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UALAddHepatitisViewController
-(void) editionDidFinished;
@end

@interface UALAddHepatitisViewController : UIViewController

@property (nonatomic, strong) id<UALAddHepatitisViewController>
delegate;
@property (nonatomic) int idPaciente;
@property (nonatomic) NSString* dniPaciente;

@property (nonatomic) int edadDiagSelected;
@property (nonatomic) int idDiagSelected;
@property (nonatomic) int sexoDiagSelected;
@property (nonatomic) int ascitisDiagSelected;
@property (nonatomic) double albuminaDiagSelected;
@property (nonatomic) int sgotDiagSelected;
@property (nonatomic) int agrandDiagSelected;
@property (nonatomic) int firmDiagSelected;
@property (nonatomic) int diagDiagSelected;
@property (nonatomic) int spidersDiagSelected;


@end
