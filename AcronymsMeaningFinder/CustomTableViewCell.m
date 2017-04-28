//
//  CustomTableViewCell.m
//  AcronymsMeaningFinder
//
//  Created by Sumirna Philips on 4/27/17.
//  Copyright © 2017 sumirnat. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
@synthesize meaningContent;
@synthesize sinceValue;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
