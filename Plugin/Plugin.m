//
//  Plugin.m
//  Plugin
//
//  Created by Sergio Sanchez Del Rio on 21/5/17.
//  Copyright © 2017 Sergio Sanchez Del Rio. All rights reserved.
//

#import "Plugin.h"

NSTimer* ellapsedTimeTimer;
BOOL isPlaying;

@implementation Plugin

- (id) init {
    self = [super init];
    if (self != nil) {
        _timesResumed = 0;
        _timesStopped = 0;
        _totalTimeEllapsed = 0;
    }
    return self;
}

-(void) addPlay{
    isPlaying = true;
    NSDictionary* postParams = @{@"action" : @"resume_content"};
    if(_timesResumed == 0){
        postParams = @{@"action" : @"first_play"};
    }
    [self postDataWithParams:postParams];
    _timesResumed++;
    ellapsedTimeTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                         target: self
                                                       selector:@selector(addTime:)
                                                       userInfo: nil repeats:YES];
    [self postDataWithParams:postParams];
}
-(void) addStop{
    if(isPlaying){
        _timesStopped++;
        [ellapsedTimeTimer invalidate];
        NSLog(@"Total times resumed %i",_timesResumed);
        NSLog(@"Total times stopped %d",_timesStopped);
        NSLog(@"Total time ellapsed %d",_totalTimeEllapsed);
        _totalTimeEllapsed = 0;
    }
    isPlaying = false;
}

-(void)addTime:(NSTimer *)timer {
    _totalTimeEllapsed++;
}

-(void)videoFinished{
    [self addStop];
    NSDictionary* postParams = @{@"action" : @"finished"};
    [self postDataWithParams:postParams];
}

-(void)postDataWithParams: (NSDictionary*) params
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://john.doe"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSData *paramsData = [NSKeyedArchiver archivedDataWithRootObject:params];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:paramsData];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                           {
                                                               //No errors
                                                           }
                                                           
                                                       }];
    [dataTask resume];
    
}


@end
