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
    final users = await UserFireBaseService().getUsersCollection().get();
    for (var user in users.docs) {
      var emailDB = user.data();
      emailDB = emailDB['_email'];
      if (emailDB == email) {
        userExists = true;
        break;
      }
    }

    return userExists;
  }

  // Login system
  Future<bool> login(User user) async {
    bool isLoginCorrect = false;
    final usersDB = await UserFireBaseService().getUsersCollection().get();
    for (var userDB in usersDB.docs) {
      String emailDB = userDB.data()['_email'];
      String passwordDB = userDB.data()['password'];
      if (emailDB == user.email && passwordDB == user.password) {
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
