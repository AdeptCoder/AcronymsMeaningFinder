//
//  CustomTableViewCell.h
//  AcronymsMeaningFinder
//
//  Created by Sumirna Philips on 4/27/17.
//  Copyright © 2017 sumirnat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *meaningContent;
@property (strong, nonatomic) IBOutlet UILabel *sinceValue;

@end
