import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key}) : super(key: key);

  final _forgotPasswordFormKey = GlobalKey<FormState>();
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
              'FORGOT PASSWORD',
              textAlign: TextAlign.center,
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
                  key: _forgotPasswordFormKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Introduce your email to send you an email with your password.',
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 40,
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
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'Enter your email',
                          ),
                          validator: _emailValidator,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        //BUTTON SEND EMAIL
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
                                if (_forgotPasswordFormKey.currentState!
                                    .validate()) {
                                  //TODO: Implement email system
                                }
                              },
                              child: const Text(
                                'Send Email',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'OpenSans',
                                    color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          height: 60,
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
