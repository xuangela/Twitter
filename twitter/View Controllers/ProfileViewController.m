//
//  ProfileViewController.m
//  twitter
//
//  Created by Angela Xu on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"
#import "APIManager.h"
#import "User.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pfpView;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowersLabel;

@property (nonatomic, strong) NSDictionary *userInfo;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

-(void) loadData {
    [[APIManager shared] getMyInfo:^(NSDictionary *userInfo, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.userInfo = userInfo;
            self.user = [[User alloc] initWithDictionary:self.userInfo];
            [self.pfpView setImageWithURL:self.user.pfpURL];
            self.numTweetsLabel.text = [NSString stringWithFormat:@"%@", self.userInfo[@"statuses_count"]];
            self.numTweetsLabel.text = [self.numTweetsLabel.text stringByAppendingString:@" tweets"];
            self.numFollowersLabel.text = [NSString stringWithFormat:@"%@", self.userInfo[@"followers_count"]];
            self.numFollowersLabel.text = [self.numFollowersLabel.text stringByAppendingString:@" followers"];
            self.numFollowingLabel.text = [NSString stringWithFormat:@"%@", self.userInfo[@"friends_count"]];
            self.numFollowingLabel.text = [self.numFollowingLabel.text stringByAppendingString:@" friends"];
            self.taglineLabel.text = self.userInfo[@"description"];
        }
    }];
    

    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
