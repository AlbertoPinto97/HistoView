import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _registerFormKey = GlobalKey<FormState>();
  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Plese enter a valid email'),
  ]);
  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  ]);
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.yellow])),
        child: Center(
          child: Column(children: [
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
              height: 30,
            ),
            //TITLE
            const Text(
              'REGISTER',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 70,
            ),
            //FORM
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45.0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'Enter your email',
                          ),
                          validator: _emailValidator,
                        ),
                        const SizedBox(
                          height: 30,
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
                          style: const TextStyle(fontSize: 15),
                          obscureText: true,
                          onChanged: (val) => _password = val,
                          decoration: const InputDecoration(
                              isDense: true, hintText: 'Enter your password'),
                          validator: _passwordValidator,
                        ),
                        const SizedBox(
                          height: 30,
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
                          validator: (val) => MatchValidator(
                                  errorText: 'Passwords do not match')
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
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45.0),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange),
                              ),
                              onPressed: () {
                                if (_registerFormKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                  //TODO: Add new account to the DB and check that the email is not being used by other user
                                }
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
            ),
          ]),
        ),
      ),
    );
  }
}
