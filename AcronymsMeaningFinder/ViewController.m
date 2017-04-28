//
//  ViewController.m
//  AcronymsMeaningFinder
//
//  Created by Sumirna Philips on 4/27/17.
//  Copyright © 2017 sumirnat. All rights reserved.
//

#import "ViewController.h"
#import "NetworkClient.h"
#import "Acronym.h"
#import "Meaning.h"
#import "VariationDetailsController.h"
#import "CustomTableViewCell.h"
#import "MBProgressHUD.h"

@interface ViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *noResultsLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Acronym *acronym;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.acronym = nil;
    self.noResultsLabel.text = @"";
   [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(![textField.text isEqualToString:@""]){
        [self meaningsFromServer:textField.text];
    }
return YES;
    
}


-(void) meaningsFromServer: (NSString *) searchContent {
    NSDictionary *parameters = @{@"sf": searchContent};
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkClient sharedManager] getResponseForURLString: @"http://www.nactem.ac.uk/software/acromine/dictionary.py?" Parameters:parameters success:^(NSURLSessionDataTask *task, Acronym *acronym) {
        printf("Success!!");
    self.acronym = acronym;
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"%@", self.acronym);
        if(self.acronym.meaningobjects.count==0)
            self.noResultsLabel.text = @"No Results!!!";
    [self.tableView reloadData];
    }
    failure:^(NSURLSessionDataTask *task, NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        printf("Error occured");
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = self.acronym.meaningobjects.count;
    if(count==0)
         [self.tableView setHidden:true];
     else
         [self.tableView setHidden:false];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"cell";
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    Meaning *newobj = self.acronym.meaningobjects[indexPath.row];
    
    cell.meaningContent.text =  newobj.actualMeaning;
    cell.sinceValue.text =  [NSString stringWithFormat:@"%zd",newobj.sincevalue];
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    VariationDetailsController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Variations"];
    Meaning *newobj = self.acronym.meaningobjects[indexPath.row];
    viewController.variationsArray =newobj.variation;
    viewController.titleVal = newobj.actualMeaning;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
