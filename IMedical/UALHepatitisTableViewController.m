//
//  UALHepatitisTableViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/29/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALHepatitisTableViewController.h"
#import "GestorBD.h"

@interface UALHepatitisTableViewController ()

@property (nonatomic, strong) GestorBD* gestorBD;
@property (nonatomic, strong) NSArray* arrayDatos;

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

@implementation UALHepatitisTableViewController

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
    self.gestorBD = [[GestorBD alloc] initWithDatabaseFilename:@"imedicalF.sqlite"];
    self.title = [NSString stringWithFormat:@"Diagnósticos Hepatitis"];
    
    [self cargarDatos];
}
-(void) editionDidFinished{
    [self cargarDatos];
}

-(void) cargarDatos{
    NSString *consulta = [NSString stringWithFormat: @"select * from diagnostico_hepatitis where PACIENTE_id=%d",self.idPaciente];
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


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addHepatitis"]){
        UALAddHepatitisViewController* destino = [segue destinationViewController];
        destino.idPaciente = self.idPaciente;
        destino.dniPaciente = self.dniPaciente;
        destino.idDiagSelected = -1;
        destino.delegate = self;
        
    }else if ([segue.identifier isEqualToString:@"detalleHepatitis"]){
        UALAddHepatitisViewController* destino = [segue destinationViewController];
        destino.dniPaciente = self.dniPaciente;
        destino.idDiagSelected = self.idDiagSelected;
        destino.edadDiagSelected = self.edadDiagSelected;
        destino.sexoDiagSelected = self.sexoDiagSelected;
        destino.ascitisDiagSelected = self.ascitisDiagSelected;
        destino.albuminaDiagSelected = self.albuminaDiagSelected;
        destino.sgotDiagSelected = self.sgotDiagSelected;
        destino.agrandDiagSelected = self.agrandDiagSelected;
        destino.firmDiagSelected = self.firmDiagSelected;
        destino.diagDiagSelected = self.diagDiagSelected;
        destino.spidersDiagSelected = self.spidersDiagSelected;
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"diagCell" forIndexPath:indexPath];
    
    NSInteger indexOfDiagnostico = [self.gestorBD.arrNombresCols indexOfObject:@"diagnostico"];
    NSInteger indexOfFecha = [self.gestorBD.arrNombresCols indexOfObject:@"fecha"];


    int diagnostico = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfDiagnostico]intValue];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfFecha]];
    
    if(diagnostico == 1) cell.detailTextLabel.text = @"POSITIVO";
    else cell.detailTextLabel.text = @"NEGATIVO";
    if(diagnostico == 1) cell.imageView.image = [UIImage imageNamed:@"alert_icon.png"];
    else cell.imageView.image = [UIImage imageNamed:@"ok_icon.png"];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexOfDiagnostico = [self.gestorBD.arrNombresCols indexOfObject:@"diagnostico"];
    NSInteger indexOfId = [self.gestorBD.arrNombresCols indexOfObject:@"id"];
    NSInteger indexOfedad = [self.gestorBD.arrNombresCols indexOfObject:@"edad"];
    NSInteger indexOfSexo = [self.gestorBD.arrNombresCols indexOfObject:@"sexo"];
    NSInteger indexOfAscitis = [self.gestorBD.arrNombresCols indexOfObject:@"ascitis"];
    NSInteger indexOfAlbumina = [self.gestorBD.arrNombresCols indexOfObject:@"albumina"];
    NSInteger indexOfSgot = [self.gestorBD.arrNombresCols indexOfObject:@"sgot"];
    NSInteger indexOfAgrand = [self.gestorBD.arrNombresCols indexOfObject:@"agrandamientoHigado"];
    NSInteger indexOffirm = [self.gestorBD.arrNombresCols indexOfObject:@"firmHigado"];
    NSInteger indexOfSpiders = [self.gestorBD.arrNombresCols indexOfObject:@"spiders"];

    indexOfedad = 1;
    
    self.idDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfId]intValue];
    self.diagDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfDiagnostico]intValue];
    self.edadDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfedad]intValue];
    self.sexoDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfSexo]intValue];
    self.ascitisDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfAscitis]intValue];
    self.albuminaDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfAlbumina]doubleValue];
    self.sgotDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfSgot]intValue];
    self.agrandDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfAgrand]intValue];
    self.firmDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOffirm]intValue];
    self.spidersDiagSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfSpiders]intValue];
    
    [self performSegueWithIdentifier:@"detalleHepatitis" sender:self];
    
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
