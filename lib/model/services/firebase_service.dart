import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histo_view/model/user.dart';

class FireBaseService {
  void registerUserToBD(User user) {
    FirebaseFirestore.instance.collection('usersRegistered').add({
      'Email': user.email,
      'Name': user.userName,
      'Password': user.password
    });
  }

  userAlreadyExist(String email) async {
    return await FirebaseFirestore.instance.collection('usersRegistered').get();
  }

  checkUserPassword(User user) async {
    return await FirebaseFirestore.instance.collection('usersRegistered').get();
  }
}
