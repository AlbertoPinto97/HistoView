import 'package:histo_view/model/review.dart';
import 'package:histo_view/model/services/review_firebase_service.dart';
import 'package:histo_view/model/services/user_firebase_service.dart';
import 'package:histo_view/model/user.dart';
import 'package:histo_view/model/user_profile.dart';

class ProfileViewModel {
  // gets user's reviews by using his email
  Future<List<Review>> getUserReviews(UserProfile user) async {
    List<Review> reviewList = [];
    // get favorite reviews relation
    final ownReviews =
        await ReviewFireBaseService().getReviewByEmail(user.email);
    // Setting user's profile
    UserProfile creator = UserProfile(user.email, user.userName, user.followers,
        user.following, user.presentation);
    for (var review in ownReviews.docs) {
      // id from user's favorite reviews
      final reviewDB = review.data();
      reviewList.add(Review(
          reviewDB['name'],
          reviewDB['creationDate'],
          reviewDB['periodDate'],
          reviewDB['locationCity'],
          reviewDB['locationCountry'],
          reviewDB['_email'],
          reviewDB['starRate'].toDouble(),
          reviewDB['countRate'],
          reviewDB['description'],
          creator));
    }
    return reviewList;
  }

  // Updates user's profile into DB
  void updateUserProfile(User user) async {
    await UserFireBaseService().updateUserProfile(user);
  }

  void followUser(String userEmail, String otherEmail) {
    //adds a follower to other user profile, followers + 1
    UserFireBaseService().addFollower(otherEmail);
    UserFireBaseService().addFollowerUser(otherEmail, userEmail);
    // current users is now folling another user, following + 1
    UserFireBaseService().addFollowing(userEmail);
  }

  void unfollowUser(String userEmail, String otherEmail) {
    //removes a follower to other user profile, followers - 1
    UserFireBaseService().removeFollower(otherEmail);
    UserFireBaseService().removeFollowerUser(otherEmail, userEmail);
    // current users is not folling another user anymore, following - 1
    UserFireBaseService().removeFollowing(userEmail);
  }

  Future<bool> isFollowing(String userEmail, String otherEmail) async {
    List<dynamic> followers = [];
    final usersDB = await UserFireBaseService().getUserByEmail(otherEmail);
    for (var userDB in usersDB.docs) {
      followers = userDB.data()['followersList'];
    }
    if (followers.isNotEmpty && followers.contains(userEmail)) {
      return true;
    }
    return false;
  }
}
