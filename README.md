# Project 3 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign in using OAuth login flow
- [x] User can Logout
- [x] User can view last 20 tweets from their home timeline
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh.
- [x] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] Using AutoLayout, the Tweet cell should adjust its layout for iPhone 11, Pro and SE device sizes as well as accommodate device rotation.
- [x] User should display the relative timestamp for each tweet "8m", "7h"
- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

The following **stretch** features are implemented:

- [x] User can view their profile in a *profile tab*
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
  - [ ] Profile view should include that user's timeline
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [ ] Links in tweets are clickable.
- [ ] User can tap the profile image in any tweet to see another user's profile
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 280) (**1 point**)
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available
- [x] User can switch between timeline, mentions, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. The workaround for viewing replies without having premium access
2. How to use the tableCell in the detail view for a tweet since the presented information overlaps a lot 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://giphy.com/gifs/YqR1UcZgiX0cSZbJPt' title='Composing a tweet' width='' alt='Composing a tweet' />
<img src='https://i.imgur.com/ZtSxGfl.gifv' title='Favoriting and Retweeting' width='' alt='Favoriting and Retweeting' />
<img src='https://i.imgur.com/fr2vLkM.gifv' title='Login and Logout' width='' alt='Login and Logout' />
<img src='https://i.imgur.com/AULZZNk.gifv' title='Replying to a tweet' width='' alt='Replying to a tweet' />
<img src='https://i.imgur.com/UtPCZRd.gifv' title='User profile' width='' alt='User profile' />
<img src='https://i.imgur.com/Pq2TNKE.gifv' title='Screen rotation' width='' alt='Screen rotation' />


GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I now have a better understanding of blocks and how they work thanks to a bug that popped up when I wasn't properly implementing a completion block.
Autolayout also took some adjusting to

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - date processing library
- [BDBOAuth1Manager](https://github.com/bdbergeron/BDBOAuth1Manager) - OAuth 1 authentication library


## License

    Copyright [2020] [Angela Xu]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
