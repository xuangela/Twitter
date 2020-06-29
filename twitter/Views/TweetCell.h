//
//  TweetCell.h
//  twitter
//
//  Created by Angela Xu on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TTTAttributedLabel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pfpView;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *timestampLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteButtonView;


@property (nonatomic, strong) NSDictionary *tweet;

@end

NS_ASSUME_NONNULL_END
