//
//  NetworkClient.h
//  AcronymsMeaningFinder
//
//  Created by Sumirna Philips on 4/27/17.
//  Copyright © 2017 sumirnat. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "Acronym.h"

typedef void (^ServiceSuccessBlock)(NSURLSessionDataTask *task, Acronym *acronym);
typedef void (^ServiceFailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface NetworkClient : AFHTTPSessionManager
+(NetworkClient *) sharedManager;

- (void)getResponseForURLString: (NSString *)urlString Parameters:(NSDictionary *) parameters success:(ServiceSuccessBlock) success failure:(ServiceFailureBlock) failure;

@end
