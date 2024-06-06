//
//  RudderCustomerIOFactory.m
//
//  Created by Arnab Pal on 29/10/19.
//

#import "RudderCustomerIOFactory.h"
#import "RudderCustomerIOIntegration.h"

@implementation RudderCustomerIOFactory

static RudderCustomerIOFactory *sharedInstance;

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (nonnull NSString *)key {
    return @"CustomerIO";
}

- (nonnull id<RSIntegration>)initiate:(nonnull NSDictionary *)config client:(nonnull RSClient *)client rudderConfig:(nonnull RSConfig *)rudderConfig {
    [RSLogger logDebug:@"Creating RudderIntegrationFactory"];
    return [[RudderCustomerIOIntegration alloc] initWithConfig:config withAnalytics:client withRudderConfig:rudderConfig];
}

@end
