import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:histo_view/viewModel/register_view_model.dart';
import 'package:histo_view/model/user.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _registerFormKey = GlobalKey<FormState>();
  final Pattern _emailPattern =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  ]);
  String _password = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameSurnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final viewModel = RegisterViewModel();
  bool _isEmailTaken = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.yellow])),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //BACK ARROW
            const SizedBox(
              height: 40,
            ),
            Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 35,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            //TITLE
            const Center(
              child: Text(
                'REGISTER',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            //FORM
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45.0)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _registerFormKey,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const SizedBox(
                    height: 50,
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
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 15),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Enter your email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!RegExp(_emailPattern.toString(),
                                caseSensitive: false)
                            .hasMatch(value)) {
                          return 'Plese enter a valid email';
                        } else if (_isEmailTaken) {
                          return 'Email is already taken';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  //NAME AND SURNAME
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Name and Surname',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          color: Colors.orange),
                    ),
                  ),
                  TextFormField(
                    controller: _nameSurnameController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(fontSize: 15),
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Enter your name and surname',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                    onChanged: (val) => _password = val,
                    decoration: const InputDecoration(
                        isDense: true, hintText: 'Enter your password'),
                    validator: _passwordValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //CONFIRM PASSWORD
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Confirm Password',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          color: Colors.orange),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 15),
                    obscureText: true,
                    decoration: const InputDecoration(
                        isDense: true, hintText: 'Confirm your password'),
                    validator: (val) =>
                        MatchValidator(errorText: 'Passwords do not match')
                            .validateMatch(val!, _password),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //ALREADY HAVEN AN ACCOUNT
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      child: const Text(
                        'Already have an account?',
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
                  //BUTTON SIGN UP
                  SizedBox(
                    height: 60,
                    width: 260,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(20),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                        ),
                        onPressed: () async {
                          User user = User(
                              _emailController.text,
                              _passwordController.text,
                              _nameSurnameController.text);
                          if (_registerFormKey.currentState!.validate()) {
                            _isEmailTaken = await viewModel
                                .userExists(_emailController.text);
                            if (!_isEmailTaken) {
                              viewModel.registerUser(user);
                              Navigator.pushNamed(context, '/accountCreated');
                            }
                          } else if (_isEmailTaken) {
                            _isEmailTaken = await viewModel
                                .userExists(_emailController.text);
                            if (!_isEmailTaken) {
                              viewModel.registerUser(user);
                              Navigator.pushNamed(context, '/accountCreated');
                            }
                          }
                          _registerFormKey.currentState!.validate();
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'OpenSans',
                              color: Colors.white),
                        )),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  emailTaken(bool isEmailTaken) {
    if (isEmailTaken) {
      return 'This Email is already taken.';
    }
    return null;
  }
}
