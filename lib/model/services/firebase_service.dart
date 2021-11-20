import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseService {
  void registerUserToBD(String email, String name, String password) {
    FirebaseFirestore.instance
        .collection('usersRegistered')
        .add({'Email': email, 'Name': name, 'Password': password});
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
}
