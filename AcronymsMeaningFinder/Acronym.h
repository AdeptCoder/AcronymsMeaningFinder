//
//  Acronym.h
//  AcronymsMeaningFinder
//
//  Created by Sumirna Philips on 4/27/17.
//  Copyright © 2017 sumirnat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Acronym : NSObject
@property (nonatomic,copy) NSString *acronymname;
@property (nonatomic,strong) NSMutableArray *meaningobjects;
@end
