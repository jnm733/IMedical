//
//  UALAddPostOperatorioViewController.h
//  IMedical
//
//  Created by Jose Luis on 8/29/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UALAddPostOperatorioViewController
-(void) editionDidFinished;
@end


@interface UALAddPostOperatorioViewController : UIViewController


@property (nonatomic, strong) id<UALAddPostOperatorioViewController> delegate;
@property (nonatomic) int idPaciente;
@property (nonatomic) NSString* dniPaciente;

@property (nonatomic) int idDiagSelected;


@end
