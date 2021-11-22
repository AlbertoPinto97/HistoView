import 'package:histo_view/model/services/firebase_service.dart';
import 'package:histo_view/model/user.dart';

class RegisterViewModel {
  void registerUser(User user) {
    FireBaseService().registerUserToBD(user);
  }

  Future<bool> userExists(String email) async {
    bool userExists = false;
    final users = await FireBaseService().userAlreadyExist(email);
    for (var user in users.docs) {
      var emailDB = user.data();
      emailDB = emailDB['Email'];
      if (emailDB == email) {
        userExists = true;
        break;
      }
    }

    return userExists;
  }

  Future<bool> login(User user) async {
    bool isLoginCorrect = false;
    final usersDB = await FireBaseService().checkUserPassword(user);
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
