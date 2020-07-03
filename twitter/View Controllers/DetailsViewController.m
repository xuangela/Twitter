//
//  DetailsViewController.m
//  twitter
//
//  Created by Angela Xu on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "NSDate+DateTools.h"
#import "Tweet.h"


@interface DetailsViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pfpView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UITextView *replytextView;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self displayTweet];
    
    self.replytextView.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // no reply button is the textfield is empty
    self.replyButton.alpha = ((self.replytextView.text.length == 0)? 0 : 1);
}

- (void) displayTweet {
    
    self.screenNameLabel.text = self.tweet.user.screenName;
    self.usernameLabel.text = self.tweet.user.name;
    self.timestampLabel.text = [self.tweet.createdAt shortTimeAgoSinceNow];
    self.tweetTextLabel.text = self.tweet.text;
    
    //cell.pfpView;
    NSURL *pfpURL = self.tweet.user.pfpURL;
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
                self.pfpView.alpha = 0;
            }];
        }
        else {
            self.pfpView.image = image;
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {}];
    
    NSString *favoriteCt = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    NSString *retweetCt = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    [self.favoriteButton setTitle:favoriteCt forState:UIControlStateNormal];
    [self.retweetButton setTitle:retweetCt forState:UIControlStateNormal];
    
    if (self.tweet.favorited) {
        self.favoriteButton.selected = YES;
    } else {
        self.favoriteButton.selected = NO;
    }
    
    if (self.tweet.retweeted) {
        self.retweetButton.selected = YES;
    } else {
        self.retweetButton.selected = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapReply:(id)sender {
    [[APIManager shared] postreplyWithText:self.replytextView.text replyTo:self.tweet.idStr completion:^(Tweet * tweet, NSError *error) {
        if (error) {
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        } else {
            [self.delegate didTweet:tweet];
            self.replytextView.text = @"";
            self.replyButton.alpha = 0;
        }
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (self.replytextView.text.length == 0) {
        [UIView animateWithDuration:1 animations:^{
            self.replyButton.alpha = 0;
        }];
    } else {
        [UIView animateWithDuration:1 animations:^{
            self.replyButton.alpha = 1;
        }];
    }
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
