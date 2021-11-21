import 'package:histo_view/model/services/firebase_service.dart';
import 'package:histo_view/model/user.dart';

class RegisterViewModel {
  void registerUser(User user) {
    FireBaseService().registerUserToBD(user);
  }

  Future<bool> userExists(String email) async {
    return await FireBaseService().userAlreadyExist(email);
  }

  Future<bool> login(User user) async {
    return await FireBaseService().checkUserPassword(user);
  }
}
