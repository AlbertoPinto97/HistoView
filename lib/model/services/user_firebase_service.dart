import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histo_view/model/user.dart';

// class used to connect to the DB and manage users
class UserFireBaseService {
  void addUser(User user) {
    FirebaseFirestore.instance
        .collection('usersRegistered')
        .doc(user.email)
        .set({
      '_email': user.email,
      'name': user.userName,
      'password': user.password,
      'followers': user.followers,
      'following': user.following,
      'presentation': user.presentation
    });
  }

  updateUserProfile(User user) {
    return FirebaseFirestore.instance
        .collection('usersRegistered')
        .doc(user.email)
        .update({
      '_email': user.email,
      'name': user.userName,
      'presentation': user.presentation
    });
  }

  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection('usersRegistered')
        .where('_email', isEqualTo: email)
        .get();
  }

  void addFollower(String email) {
    FirebaseFirestore.instance
        .collection('usersRegistered')
        .doc(email)
        .update({'followers': FieldValue.increment(1)});
  }

  void addFollowing(String email) {
    FirebaseFirestore.instance
        .collection('usersRegistered')
        .doc(email)
        .update({'following': FieldValue.increment(1)});
  }

  void addFollowerUser(String email, String emailToRemove) {
    FirebaseFirestore.instance.collection('usersRegistered').doc(email).update({
      'followersList': FieldValue.arrayUnion([emailToRemove])
    });
  }

  void removeFollower(String email) {
    FirebaseFirestore.instance
        .collection('usersRegistered')
        .doc(email)
        .update({'followers': FieldValue.increment(-1)});
  }

  void removeFollowing(String email) {
    FirebaseFirestore.instance
        .collection('usersRegistered')
        .doc(email)
        .update({'following': FieldValue.increment(-1)});
  }

  void removeFollowerUser(String email, String emailToRemove) {
    FirebaseFirestore.instance.collection('usersRegistered').doc(email).update({
      'followersList': FieldValue.arrayRemove([emailToRemove])
    });
  }
}
