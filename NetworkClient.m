//
//  NetworkClient.m
//  AcronymsMeaningFinder
//
//  Created by Sumirna Philips on 4/27/17.
//  Copyright © 2017 sumirnat. All rights reserved.
//

#import "NetworkClient.h"
#import "Acronym.h"
#import "Meaning.h"

@implementation NetworkClient
+(NetworkClient *) sharedManager {
    
    static NetworkClient *sharedManager = nil;
    static dispatch_once_t once ;
    dispatch_once(&once, ^{
        sharedManager = [[NetworkClient alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

- (void)getResponseForURLString: (NSString *)urlString Parameters:(NSDictionary *) parameters success:(ServiceSuccessBlock) success failure:(ServiceFailureBlock) failure
{
      self.responseSerializer.acceptableContentTypes = nil;
    [self GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, NSArray *response){
        if (success) {
            success(task, [self parseResponse:response]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }}];
}

-(Acronym *) parseResponse:(NSArray *) response {
        for(NSDictionary *dictval in response){
            Acronym *acronym = [[Acronym alloc] init];
            [acronym setAcronymname: [dictval objectForKey:@"sf"]] ;
            [acronym setMeaningobjects:[self getMeaningObjects:[dictval objectForKey:@"lfs"]]];
            return acronym;
        }
    return nil;
}

-(NSMutableArray *) getMeaningObjects:(NSMutableArray *) response {
    NSMutableArray *meaningArr = [NSMutableArray array];
    for(NSDictionary *dictval in response){
        Meaning *meaning = [[Meaning alloc] init];
        [meaning setActualMeaning: [dictval objectForKey:@"lf"]] ;
        [meaning setFreq: [[dictval objectForKey:@"freq"] integerValue]] ;
        [meaning setSincevalue: [[dictval objectForKey:@"since"] integerValue]] ;
        [meaning setVariation:[self getVariationDetails:[dictval objectForKey:@"vars"]]];
        [meaningArr addObject:meaning];
    }
    return meaningArr;
}

-(NSMutableArray *) getVariationDetails:(NSMutableArray *) response {
    NSMutableArray *variationsAr = [NSMutableArray array];
    for(NSDictionary *dictval in response){
        
        Meaning *meaning = [[Meaning alloc] init];
        [meaning setActualMeaning: [dictval objectForKey:@"lf"]] ;
        [meaning setFreq: [[dictval objectForKey:@"freq"] integerValue]] ;
        [meaning setSincevalue: [[dictval objectForKey:@"since"] integerValue]] ;
        
        [variationsAr addObject:meaning];
    }
    return variationsAr;
}


@end
