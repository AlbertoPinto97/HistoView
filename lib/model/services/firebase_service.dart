import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histo_view/model/user.dart';

class FireBaseService {
  void registerUserToBD(User user) {
    FirebaseFirestore.instance.collection('usersRegistered').add(
        {'Email': user.email, 'Name': user.name, 'Password': user.password});
  }

  Future<bool> userAlreadyExist(String email) async {
    bool userExists = false;
    final users =
        await FirebaseFirestore.instance.collection('usersRegistered').get();
    for (var user in users.docs) {
      String emailDB = user.data()['Email'];
      if (emailDB == email) {
        userExists = true;
        break;
      }
    }
    return userExists;
  }

  Future<bool> checkUserPassword(User user) async {
    bool isLoginCorrect = false;
    final usersDB =
        await FirebaseFirestore.instance.collection('usersRegistered').get();
    for (var userDB in usersDB.docs) {
      String emailDB = userDB.data()['Email'];
      String passwordDB = userDB.data()['Password'];
      if (emailDB == user.email && passwordDB == user.password) {
        isLoginCorrect = true;
        break;
      }
    }
    return isLoginCorrect;
  }
}
