//
//  NetObjc.h
//  Pods
//
//  Created by zixun on 17/1/4.
//
//

#import <Foundation/Foundation.h>

@class NetModel;
@interface NetObjc : NSObject

+ (nonnull NetModel *)flow;

+ (nullable NSString *)wifiIPAddress;

+ (nullable NSString *)wifiNetmaskAddress;

+ (nullable NSString *)cellIPAddress;

+ (nullable NSString *)cellNetmaskAddress;
@end

@interface NetModel : NSObject

@property (nonatomic,assign) u_int32_t wifiSend;
@property (nonatomic,assign) u_int32_t wifiReceived;
@property (nonatomic,assign) u_int32_t wwanSend;
@property (nonatomic,assign) u_int32_t wwanReceived;

@end
