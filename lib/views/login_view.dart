import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginFormKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Plese enter a valid email')
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
                          validator: passwordValidator,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //FORGOT PASSWORD
                        Container(
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
                        const SizedBox(
                          height: 50,
                        ),
                        //BUTTON LOGIN
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              },
                              child: const Text(
                                'Login',
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
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.orange),
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
