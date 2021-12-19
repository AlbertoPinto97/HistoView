import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:histo_view/model/current_user.dart';
import 'package:histo_view/viewModel/register_login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Plese enter a valid email'),
  ]);
  final _viewModel = RegisterLoginViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _correctLogin = true;
  bool _rememberLogin = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final CurrentUser _user = CurrentUser();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLoginInfo();
  }

  // get login info if there's any stored to login automatically
  _getLoginInfo() async {
    final SharedPreferences prefs = await _prefs;
    _rememberLogin = prefs.getBool('remember') ?? false;
    if (_rememberLogin) {
      _user.email = prefs.getString('email') ?? "";
      _user.password = prefs.getString('password') ?? "";
      await _viewModel.login(_user);
      Navigator.pushNamed(context, '/tabBar');
    } else {
      _isLoading = false;
    }
    setState(() {});
  }

  // stores login's information
  _remember(String email, String password) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('remember', _rememberLogin);
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = "";
    _passwordController.text = "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _isLoading
          ? Container(
              color: Colors.white,
            )
          : Container(
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.red, Colors.yellow])),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      //TITLE
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      //FORM
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(45.0)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  height: 70,
                                ),
                                //EMAIL
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    'Email',
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 20,
                                        color: Colors.orange),
                                  ),
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  style: const TextStyle(fontSize: 15),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    hintText: 'Enter your email',
                                  ),
                                  validator: _emailValidator,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                //PASSWORD
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    'Password',
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 20,
                                        color: Colors.orange),
                                  ),
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  style: const TextStyle(fontSize: 15),
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      isDense: true,
                                      hintText: 'Enter your password'),
                                  validator: RequiredValidator(
                                      errorText: 'Password is required'),
                                ),
                                // REMEMBER ME
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Remember me",
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 12,
                                          color: Colors.orange),
                                    ),
                                    StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return Checkbox(
                                          value: _rememberLogin,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _rememberLogin = value!;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (!_correctLogin)
                                  const Text(
                                    'Incorrect login, please try again.',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontFamily: 'Open Sans'),
                                  ),
                                if (!_correctLogin)
                                  const SizedBox(
                                    height: 20,
                                  ),
                                //FORGOT PASSWORD
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/forgotPassword');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.orange),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                //BUTTON SIGN IN
                                SizedBox(
                                  height: 60,
                                  width: 260,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all(20),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                        )),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.orange),
                                      ),
                                      onPressed: () async {
                                        _user.setEmailPassword(
                                            _emailController.text,
                                            _passwordController.text);
                                        if (_loginFormKey.currentState!
                                            .validate()) {
                                          _correctLogin =
                                              await _viewModel.login(_user);
                                          if (_correctLogin) {
                                            _remember(
                                                _user.email, _user.password);

                                            Navigator.pushNamed(
                                                context, '/tabBar');
                                          }
                                        }
                                        setState(() {});
                                      },
                                      child: const Text(
                                        'Sign in',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'OpenSans',
                                            color: Colors.white),
                                      )),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                //DON'T HAVE AN ACCOUNT
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: const Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.orange),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ]),
              ),
            ),
    );
  }
}
