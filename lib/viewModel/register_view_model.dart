import 'package:histo_view/model/services/user_firebase_service.dart';
import 'package:histo_view/model/user.dart';

class RegisterViewModel {
  // Register a user to the DB
  void registerUser(User user) {
    UserFireBaseService().registerUserToBD(user);
  }

  // Checks if any user has @param email
  Future<bool> userExists(String email) async {
    bool userExists = false;
    final users = await UserFireBaseService().userAlreadyExist();
    for (var user in users.docs) {
      var emailDB = user.data();
      emailDB = emailDB['email'];
      if (emailDB == email) {
        userExists = true;
        break;
      }
    }

    return userExists;
  }

  // Login
  Future<bool> login(User user) async {
    bool isLoginCorrect = false;
    final usersDB = await UserFireBaseService().checkUserPassword();
    for (var userDB in usersDB.docs) {
      String emailDB = userDB.data()['email'];
      String passwordDB = userDB.data()['password'];
      if (emailDB == user.email && passwordDB == user.password) {
        isLoginCorrect = true;
        break;
      }
    }
    return isLoginCorrect;
  }
}
