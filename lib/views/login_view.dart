import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _loginFormKey = GlobalKey<FormState>();
  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Plese enter a valid email'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.yellow])),
        child: Center(
          child: Column(children: [
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
                  key: _loginFormKey,
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
                          decoration: const InputDecoration(
                              isDense: true, hintText: 'Enter your password'),
                          validator: RequiredValidator(
                              errorText: 'Password is required'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //FORGOT PASSWORD
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgotPassword');
                          },
                          child: Container(
                            alignment: Alignment.topRight,
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
                          height: 50,
                        ),
                        //BUTTON SIGN IN
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
                                if (_loginFormKey.currentState!.validate()) {
                                  //TODO: Login system
                                }
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
                          height: 40,
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
            ),
          ]),
        ),
      ),
    );
  }
}
