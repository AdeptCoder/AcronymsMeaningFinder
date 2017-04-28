//
//  VariationDetailsController.m
//  AcronymsMeaningFinder
//
//  Created by Sumirna Philips on 4/27/17.
//  Copyright © 2017 sumirnat. All rights reserved.
//

#import "VariationDetailsController.h"
#import "Meaning.h"
@interface VariationDetailsController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *variationTableView;
@end


@implementation VariationDetailsController
@synthesize variationsArray;
@synthesize titleVal;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.variationsArray.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *titleval = [@"Variations for '" stringByAppendingString:[self.titleVal stringByAppendingString:@"'"]];
    return titleval;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    Meaning *newobj = self.variationsArray[indexPath.row];
    cell.textLabel.text =  newobj.actualMeaning;
    return cell;
}



- (IBAction)doneAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
