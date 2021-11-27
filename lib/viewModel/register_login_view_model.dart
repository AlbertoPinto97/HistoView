import 'package:histo_view/model/services/user_firebase_service.dart';
import 'package:histo_view/model/user.dart';

class RegisterLoginViewModel {
  // Register a user to the DB
  void registerUser(User user) {
    UserFireBaseService().addUser(user);
  }

  // Checks if any user has @param email
  Future<bool> userExists(String email) async {
    bool userExists = false;
    final users = await UserFireBaseService().getUserByEmail(email);
    if (users.size > 0) {
      userExists = true;
    }

    return userExists;
  }

  // Login system
  Future<bool> login(User user) async {
    bool isLoginCorrect = false;
    final usersDB = await UserFireBaseService().getUserByEmail(user.email);
    for (var userDB in usersDB.docs) {
      String passwordDB = userDB.data()['password'];
      if (passwordDB == user.password) {
        user.presentation = userDB.data()['presentation'];
        user.userName = userDB.data()['name'];
        user.followers = userDB.data()['followers'];
        user.following = userDB.data()['following'];
        isLoginCorrect = true;
        break;
      }
    }
    return isLoginCorrect;
  }
}
