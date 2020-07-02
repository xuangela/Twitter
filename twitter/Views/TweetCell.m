//
//  TweetCell.m
//  twitter
//
//  Created by Angela Xu on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "NSDate+DateTools.h"

@implementation TweetCell

-(void) setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.screenNameLabel.text = tweet.user.screenName;
    self.usernameLabel.text = tweet.user.name;
    self.timestampLabel.text = [tweet.createdAt shortTimeAgoSinceNow];
    self.tweetTextLabel.text = tweet.text;
    
    //cell.pfpView;
    NSURL *pfpURL = tweet.user.pfpURL;
    NSURLRequest *pfpRequest = [NSURLRequest requestWithURL:pfpURL];
    
    [self.pfpView setImageWithURLRequest:pfpRequest placeholderImage:nil
    success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
        
        // imageResponse will be nil if the image is cached
        // fade in if not cached
        if (imageResponse) {
            self.pfpView.alpha = 0.0;
            self.pfpView.image = image;
            
            //Animate UIImageView back to alpha 1 over 0.3sec
            [UIView animateWithDuration:0.3 animations:^{
                self.pfpView.alpha = 1.0;
            }];
        }
        else {
            self.pfpView.image = image;
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {}];
    
    NSString *favoriteCt = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    NSString *retweetCt = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    [self.favoriteButton setTitle:favoriteCt forState:UIControlStateNormal];
    [self.retweetButton setTitle:retweetCt forState:UIControlStateNormal];
    
    if (tweet.favorited) {
        self.favoriteButton.selected = YES;
    } else {
        self.favoriteButton.selected = NO;
    }
    
    if (tweet.retweeted) {
        self.retweetButton.selected = YES;
    } else {
        self.retweetButton.selected = NO;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    int increment = (self.tweet.favorited) ? -1 : 1;
    self.tweet.favoriteCount += increment;
    self.tweet.favorited = !self.tweet.favorited;

    [self refreshData];
    
    if (self.tweet.favorited) {
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) { }];
    } else {
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) { }];
    }
}
- (IBAction)didTapRetweet:(id)sender {
    int increment = (self.tweet.retweeted) ? -1 : 1;
    self.tweet.retweetCount += increment;
    self.tweet.retweeted = !self.tweet.retweeted;

    [self refreshData];
    
    if (self.tweet.retweeted) {
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) { }];
    } else {
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) { }];
    }
}

-  (void)refreshData {
    NSString *favoriteCt = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    NSString *retweetCt = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    [self.favoriteButton setTitle:favoriteCt forState:UIControlStateNormal];
    [self.retweetButton setTitle:retweetCt forState:UIControlStateNormal];
    
    self.favoriteButton.selected = self.tweet.favorited;
    self.retweetButton.selected = self.tweet.retweeted;
}

@end
