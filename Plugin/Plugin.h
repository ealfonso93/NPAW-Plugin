//
//  Plugin.h
//  Plugin
//
//  Created by Sergio Sanchez Del Rio on 21/5/17.
//  Copyright © 2017 Sergio Sanchez Del Rio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plugin : NSObject
@property (nonatomic,readonly) int totalTimeEllapsed;
@property (nonatomic,readonly) int timesResumed;
@property (nonatomic,readonly) int timesStopped;

-(void) addPlay;
-(void) addStop;
-(void)videoFinished;

//-(int) totalTimeEllapsed;

@end
