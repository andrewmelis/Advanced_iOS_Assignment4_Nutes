//
//  NSString+Now.m
//  Nutes
//
//  Created by Andrew Melis on 5/29/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import "NSString+Now.h"

@implementation NSString (Now)

-(NSString*)getCurrentTimeString:(NSString*)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSDate *today = [NSDate date];
    string = [dateFormatter stringFromDate:today];
    
    return string;
}


@end
