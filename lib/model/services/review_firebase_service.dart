import 'package:cloud_firestore/cloud_firestore.dart';

// class used to connect to the DB and manage reviews
class ReviewFireBaseService {
  getFavoritesReviews(String email) async {
    return await FirebaseFirestore.instance
        .collection('favoriteReviews')
        .where('_user_email', isEqualTo: email)
        .get();
  }

  getReviewById(int id) async {
    return await FirebaseFirestore.instance
        .collection('reviews')
        .where('_id', isEqualTo: id)
        .get();
  }

  getReviewByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection('reviews')
        .where('_email', isEqualTo: email)
        .get();
  }
}
