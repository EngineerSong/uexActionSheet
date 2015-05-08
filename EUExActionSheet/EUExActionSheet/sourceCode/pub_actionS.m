//
//  pub_actionS.m
//  AppCan
//
//  Created by AppCan on 13-8-7.
//
//

#import "pub_actionS.h"
#import "EUtility.h"

@implementation pub_actionS

+ (UIColor *)stringToColor:(NSString *)aString {
    if ([aString isKindOfClass:[NSString class]] && aString.length > 0) {
        UIColor * color = [EUtility ColorFromString:aString];
        return color;
    } else {
        return nil;
    }
}

@end
