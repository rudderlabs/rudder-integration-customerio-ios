//
//  RudderCustomerIOFactory.h
//
//  Created by Arnab Pal on 29/10/19.
//

#import <Foundation/Foundation.h>
#import <Rudder/RSIntegrationFactory.h>

NS_ASSUME_NONNULL_BEGIN

@interface RudderCustomerIOFactory : NSObject<RSIntegrationFactory>

+ (instancetype) instance;

@end

NS_ASSUME_NONNULL_END
