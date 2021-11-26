import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histo_view/model/user.dart';

// class used to connect to the DB and manage users
class UserFireBaseService {
  void addUser(User user) {
    FirebaseFirestore.instance.collection('usersRegistered').add({
      '_email': user.email,
      'name': user.userName,
      'password': user.password,
      'followers': user.followers,
      'following': user.following,
      'presentation': user.presentation
    });
  }

  getUsersCollection() {
    return FirebaseFirestore.instance.collection('usersRegistered');
  }
}
