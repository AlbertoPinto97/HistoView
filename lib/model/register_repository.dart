import 'package:histo_view/model/services/firebase_service.dart';

class RegisterRepository {
  void registerUser(String email, String name, String password) {
    FireBaseService().registerUserToBD(email, name, password);
  }

  Future<bool> userExists(String email) async {
    return await FireBaseService().userAlreadyExist(email);
  }
}
