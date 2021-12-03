// This class uses the singleton pattern
class CurrentUser {
  late String email;
  late String password;
  late String userName;
  late String presentation;
  late int followers;
  late int following;

  static final CurrentUser _currentUser = CurrentUser._internal();

  CurrentUser._internal();

  factory CurrentUser() {
    return _currentUser;
  }

  void setEmailPassword(String email, String password) {
    _currentUser.email = email;
    _currentUser.password = password;
  }

  void setParams(String email, String password, String username, int followers,
      int following, String presentation) {
    _currentUser.email = email;
    _currentUser.password = password;
    _currentUser.userName = username;
    _currentUser.followers = followers;
    _currentUser.following = following;
    _currentUser.presentation = presentation;
  }
}
