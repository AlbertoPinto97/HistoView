import 'package:histo_view/model/review.dart';
import 'package:histo_view/model/services/review_firebase_service.dart';
import 'package:histo_view/model/services/user_firebase_service.dart';
import 'package:histo_view/model/user.dart';

class ProfileViewModel {
  // gets user's reviews by using his email
  Future<List<Review>> getUserReviews(String email) async {
    List<Review> reviewList = [];
    // get favorite reviews relation
    final ownReviews = await ReviewFireBaseService().getReviewByEmail(email);
    for (var review in ownReviews.docs) {
      // id from user's favorite reviews
      final reviewDB = review.data();
      reviewList.add(Review(
          reviewDB['name'],
          reviewDB['creation_date'],
          reviewDB['period_date'],
          reviewDB['location_city'],
          reviewDB['location_country'],
          reviewDB['_email'],
          reviewDB['star_rate'].toDouble(),
          reviewDB['count_rate'],
          reviewDB['description'],
          reviewDB['creator_name']));
    }
    return reviewList;
  }

  // Updates user's profile into DB
  void updateUserProfile(User user) async {
    var userCollection = await UserFireBaseService().getUsersCollection();
    userCollection.doc('UCKBg2Al7IPzeeoPvcMg').update({
      '_email': user.email,
      'name': user.userName,
      'presentation': user.presentation
    });
  }
}
