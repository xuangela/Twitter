//
//  DetailsViewController.h
//  twitter
//
//  Created by Angela Xu on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DetailViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, weak) id<DetailViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
