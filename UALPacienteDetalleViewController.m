//
//  UALPacienteDetalleViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/28/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALPacienteDetalleViewController.h"
#import "UALHepatitisTableViewController.h"
#import "UALPostOperatorioTableViewController.h"

@interface UALPacienteDetalleViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UILabel *dni;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imagen;

@end

@implementation UALPacienteDetalleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@, %@", self.nombrePaciente, self.dniPaciente];
    self.nombre.text = [NSString stringWithFormat:@"%@, %@", self.apellidosPaciente, self.nombrePaciente];
    self.dni.text = self.dniPaciente;
    NSData *pngData = [NSData dataWithContentsOfFile:self.imagenPaciente];
    UIImage *image = [UIImage imageWithData:pngData];
    self.imagen.image = image;

    #ifndef VERSION3
    self.postButton.hidden = YES;
    self.postLabel.hidden = YES;
    #endif
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"hepatitisList"]){
        UALHepatitisTableViewController* destino = [segue destinationViewController];
        destino.idPaciente = self.idPaciente;
        destino.dniPaciente = self.dniPaciente;
    }else if ([segue.identifier isEqualToString:@"postOperatorioList"]){
        UALPostOperatorioTableViewController* destino = [segue destinationViewController];
        destino.idPaciente = self.idPaciente;
        destino.dniPaciente = self.dniPaciente;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
