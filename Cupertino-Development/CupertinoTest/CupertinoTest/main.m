//
//  main.m
//  CupertinoTest
//
//  Created by The Three Monkeys on 2020-09-29.
//

#import <Foundation/Foundation.h>

/// This object makes all the requests for the api
@interface RequestObject : NSObject
@property (nonatomic,retain) NSString *domain;
@property (nonatomic,retain) NSString *requestEncoding;
-(id)initWithDomain:(NSString*)domainName;
-(NSMutableDictionary*)makeRequest:(NSString*)requestType requestEndpoint:(NSString*)endpoint requestParameters:(NSString*)params;
@end

/// Method definition
@implementation RequestObject: NSObject
@synthesize domain;
@synthesize requestEncoding;
-(id)init {
    self = [super init];
    if (self) {
        self.domain = @"https://cupertino-api.herokuapp.com";
        self.requestEncoding = @"application/json";
    }
    return self;
}
-(id)initWithDomain:(NSString *)domainName {
    self = [super init];
    if (self) {
        self.domain = domainName;
        self.requestEncoding = @"application/json";
    }
    return self;
}
-(NSMutableDictionary*)makeRequest:(NSString*)requestType requestEndpoint:(NSString*)endpoint requestParameters:(NSString* _Nullable)params; {
    NSError *finalError;
    __block NSData *rawRequestResponse;
    NSURL *fullURL = [NSURL URLWithString:[self.domain stringByAppendingString:endpoint]];
    if (params == nil) {
        params = @"";
    }
    NSData *requestBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:fullURL];
    [request setHTTPMethod:requestType];
    [request setHTTPBody:requestBody];
    [request addValue:self.requestEncoding forHTTPHeaderField:@"Content-Type"];
    
    __unused NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSLog(@"data exists");
            rawRequestResponse = data;
        } else {
            NSLog(@"Data does not exist");
            rawRequestResponse = [[NSData alloc] init];
        }
    }];
    NSMutableDictionary *finalDict = [NSJSONSerialization JSONObjectWithData:rawRequestResponse options:NSJSONReadingMutableContainers error:&finalError];
    return finalDict;
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog (@"Starting");
            RequestObject *sender = [[RequestObject alloc] init];
            NSMutableDictionary *pinger = [sender makeRequest:@"GET" requestEndpoint:@"/ping" requestParameters:NULL];
            NSArray *pingerArray = [pinger allKeys];
                for (NSString *key in pingerArray) {
                    id value = [pinger valueForKey:key];
                    NSString *valueString = @"";
                    
                    if ([value isKindOfClass:[NSString class]])
                        valueString = (NSString *)value;
                    else if ([value isKindOfClass:[NSNumber class]])
                        valueString = [(NSNumber *)value stringValue];
                    
                    NSLog(@"    %@: %@", key, valueString);
                }
        }
    return 0;
}
