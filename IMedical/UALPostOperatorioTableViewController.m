//
//  UALPostOperatorioTableViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/29/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALPostOperatorioTableViewController.h"
#import "GestorBD.h"

@interface UALPostOperatorioTableViewController ()

@property (nonatomic, strong) GestorBD* gestorBD;
@property (nonatomic, strong) NSArray* arrayDatos;

@property (nonatomic) int idDiagSelected;



@end

@implementation UALPostOperatorioTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabla.delegate = self;
    self.tabla.dataSource = self;
    self.gestorBD = [[GestorBD alloc] initWithDatabaseFilename:@"imedicalFinal.sqlite"];
    self.title = [NSString stringWithFormat:@"Diagnósticos PostOperatorios"];
    
    [self cargarDatos];
}

-(void) editionDidFinished{
    [self cargarDatos];
}

-(void) cargarDatos{
    NSString *consulta = [NSString stringWithFormat: @"select * from diagnostico_postoperatorio where PACIENTE_id=%d",self.idPaciente];
    if (self.arrayDatos != nil) self.arrayDatos = nil;
    self.arrayDatos = [[NSArray alloc] initWithArray:[self.gestorBD
                                                      selectFromDB:consulta]];
    //actualizamos la tabla
    [self.tabla reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrayDatos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    
    NSInteger indexOfDiagnostico = [self.gestorBD.arrNombresCols indexOfObject:@"decision"];
    NSInteger indexOfFecha = [self.gestorBD.arrNombresCols indexOfObject:@"fecha"];
    
    
    int diagnostico = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfDiagnostico]intValue];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfFecha]];
    if (diagnostico == 1) {
        cell.detailTextLabel.text = @"Listo para el alta médica";
        cell.imageView.image = [UIImage imageNamed:@"goHome_icon.png"];
    }else if (diagnostico == 2){
        cell.detailTextLabel.text = @"Enviar a planta general de hospital";
        cell.imageView.image = [UIImage imageNamed:@"hospital_icon.png"];
    }else{
        cell.detailTextLabel.text = @"Enviar a UCI";
        cell.imageView.image = [UIImage imageNamed:@"uci_icon.png"];
    }
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addPostOperatorio"]){
        UALAddPostOperatorioViewController* destino = [segue destinationViewController];
        destino.idPaciente = self.idPaciente;
        destino.dniPaciente = self.dniPaciente;
        destino.idDiagSelected = -1;
        destino.delegate = self;
        
    }else if ([segue.identifier isEqualToString:@"detallePost"]){
        UALAddPostOperatorioViewController* destino = [segue destinationViewController];
        destino.dniPaciente = self.dniPaciente;
        destino.idDiagSelected = self.idDiagSelected;
        destino.idPaciente = self.idPaciente;
        destino.delegate = self;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexOfId = [self.gestorBD.arrNombresCols indexOfObject:@"id"];
    
    self.idDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfId]intValue];
    
    [self performSegueWithIdentifier:@"detallePost" sender:self];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
