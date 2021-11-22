// ignore_for_file: prefer_initializing_formals

class User {
  late String email;
  late String password;
  late String userName;

  static final User _user = User._internal();

  User._internal();

  factory User(String email, String password, [name = '']) {
    _user.email = email;
    _user.password = password;
    if (name != '') {
      _user.userName = name;
    }
    return _user;
  }

  set name(String value) {
    _user.userName = value;
  }
}
