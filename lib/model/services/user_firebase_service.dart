import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histo_view/model/user.dart';

class UserFireBaseService {
  void registerUserToBD(User user) {
    FirebaseFirestore.instance.collection('usersRegistered').add({
      'email': user.email,
      'name': user.userName,
      'password': user.password
    });
  }

  userAlreadyExist() async {
    return await FirebaseFirestore.instance.collection('usersRegistered').get();
  }

  checkUserPassword() async {
    return await FirebaseFirestore.instance.collection('usersRegistered').get();
  }
}
