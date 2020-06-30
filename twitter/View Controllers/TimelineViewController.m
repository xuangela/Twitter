//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"


@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 200;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self beginRefresh:refreshControl];
    
}

// Makes a network request to get updated data
  // Updates the tableView with the new data
  // Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [refreshControl beginRefreshing];

    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");

            self.tweets = [NSMutableArray arrayWithArray:tweets];
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
    [self.tableView reloadData];
    [refreshControl endRefreshing];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweets[indexPath.row];

    cell.screenNameLabel.text = tweet.user.screenName;
    cell.usernameLabel.text = tweet.user.name;
    cell.timestampLabel.text = tweet.createdAtString;
    cell.tweetTextLabel.text = tweet.text;

    //cell.pfpView;
    NSURL *pfpURL = tweet.user.pfpURL;
    NSURLRequest *pfpRequest = [NSURLRequest requestWithURL:pfpURL];
    
    [cell.pfpView setImageWithURLRequest:pfpRequest placeholderImage:nil
    success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
        
        // imageResponse will be nil if the image is cached
        if (imageResponse) {
            NSLog(@"Image was NOT cached, fade in image");
            cell.pfpView.alpha = 0.0;
            cell.pfpView.image = image;
            
            //Animate UIImageView back to alpha 1 over 0.3sec
            [UIView animateWithDuration:0.3 animations:^{
                cell.pfpView.alpha = 1.0;
            }];
        }
        else {
            NSLog(@"Image was cached so just update the image");
            cell.pfpView.image = image;
        }
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {}];
    
    NSString *favoriteCt = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    NSString *retweetCt = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    [cell.favoriteButton setTitle:favoriteCt forState:UIControlStateNormal];
    [cell.retweetButton setTitle:retweetCt forState:UIControlStateNormal];
    
    if (tweet.favorited) {
        cell.favoriteButton.selected = YES;
    } else {
        cell.favoriteButton.selected = NO;
    }
    
    if (tweet.retweeted) {
        cell.retweetButton.selected = YES;
    } else {
        cell.retweetButton.selected = NO;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end
