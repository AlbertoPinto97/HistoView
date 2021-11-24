// ignore_for_file: prefer_initializing_formals

class User {
  late String email;
  late String password;
  late String userName;

  static final User _user = User._internal();

  User._internal();

  factory User() {
    return _user;
  }

  void setEmailPassword(String email, String password) {
    _user.email = email;
    _user.password = password;
  }

  void setParams(String email, String password, String username) {
    _user.email = email;
    _user.password = password;
    _user.userName = username;
  }
}
