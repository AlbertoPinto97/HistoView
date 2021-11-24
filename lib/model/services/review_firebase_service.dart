import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewFireBaseService {
  getFavoritesReviews(String email) async {
    return await FirebaseFirestore.instance
        .collection('favoriteReviews')
        .where('_user_email', isEqualTo: email)
        .get();
  }

  getReview(int id) async {
    return await FirebaseFirestore.instance
        .collection('reviews')
        .where('_id', isEqualTo: id)
        .get();
  }
}
