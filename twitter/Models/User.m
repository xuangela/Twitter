//
//  User.m
//  twitter
//
//  Created by Angela Xu on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = [@"@" stringByAppendingString:dictionary[@"screen_name"]];
        
        NSString *pfpURLString = [dictionary[@"profile_image_url_https"] stringByReplacingOccurrencesOfString:@"_normal" withString:@""];;
        self.pfpURL = [NSURL URLWithString:pfpURLString];    }
    return self;
}

@end
