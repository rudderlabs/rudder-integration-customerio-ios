//
//  RudderCustomerIOIntegration.m
//
//  Created by Arnab Pal on 29/10/19.
//

#import "RudderCustomerIOIntegration.h"

@implementation RudderCustomerIOIntegration

#pragma mark - Initialization

- (instancetype)initWithConfig:(NSDictionary *)config withAnalytics:(nonnull RSClient *)client  withRudderConfig:(nonnull RSConfig *)rudderConfig {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dump:(RSMessage *)message {
    if (message != nil) {
        [self processRudderEvent:message];
    }
}

- (void) processRudderEvent: (nonnull RSMessage *) message {
    
}

- (void)reset {
}

- (void)flush {
    // CustomerIO doesn't support flush functionality
}


@end

