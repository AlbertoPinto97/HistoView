// This class uses the singleton pattern
class User {
  late String email;
  late String password;
  late String userName;
  late String presentation;
  late int followers;
  late int following;

  static final User _user = User._internal();

  User._internal();

  factory User() {
    return _user;
  }

  void setEmailPassword(String email, String password) {
    _user.email = email;
    _user.password = password;
  }

  void setParams(String email, String password, String username, int followers,
      int following, String presentation) {
    _user.email = email;
    _user.password = password;
    _user.userName = username;
    _user.followers = followers;
    _user.following = following;
    _user.presentation = presentation;
  }
}
