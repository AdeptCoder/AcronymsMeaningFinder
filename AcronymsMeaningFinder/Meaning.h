//
//  Meaning.h
//  AcronymsMeaningFinder
//
//  Created by Sumirna Philips on 4/27/17.
//  Copyright © 2017 sumirnat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meaning : NSObject
@property (nonatomic, copy) NSString *actualMeaning;
@property NSInteger freq;
@property NSInteger sincevalue;
@property (nonatomic, copy) NSMutableArray *variation;
@end
