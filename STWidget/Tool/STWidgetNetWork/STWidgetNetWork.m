//
//  STWidgetNetWork.m
//  todayWidget
//
//  Created by StarHui on 2017/3/13.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STWidgetNetWork.h"

@implementation STWidgetNetWork

+ (void)asyncPost:(NSString *)usrStr params:(NSDictionary *)params resultBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError))resultBlock {
    /** 服务器地址 */
    NSURL *mURL = [NSURL URLWithString:usrStr];
    NSString *dataStr = [self parseParams:params];
    NSData *mPostData = [dataStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *mRequest = [self requestWithURL:mURL httpData:mPostData];
    [NSURLConnection sendAsynchronousRequest:mRequest
                                       queue:[NSOperationQueue new]
                           completionHandler:^(NSURLResponse *_Nullable response, NSData *_Nullable data, NSError *_Nullable connectionError) {
                               resultBlock(response, data, connectionError);
                               NSLog(@"\n-------------------------\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                           }];
}

+ (NSMutableURLRequest *)requestWithURL:(NSURL *)mURL httpData:(NSData *)mData {
    NSLog(@"\nTodayView Url:\n%@", [mURL absoluteString]);
    NSLog(@"\nTodayView Data:\n%@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:mURL
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[@(mData.length)stringValue] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:mData];
    return request;
}
+(NSString *)parseParams:(NSDictionary *)params {
    // 得到所有的参数
    NSArray *keys = [params allKeys];
    
    // 对所有的参数进行排序:升序
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult (NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableString *strURL = [NSMutableString string];
    for (NSString *key in keys) {
        NSString *valueSTR = params[key];
        [strURL appendString:[NSString stringWithFormat:@"%@=%@&", key, valueSTR]];
    }
    return [strURL copy];
}
@end
