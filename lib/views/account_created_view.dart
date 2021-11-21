import 'package:flutter/material.dart';

class AccountCreatedView extends StatelessWidget {
  const AccountCreatedView({Key? key}) : super(key: key);

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
              'NEW ACCOUNT CREATED',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 70,
            ),
            //WHITE PART
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45.0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 125,
                      ),
                      const SizedBox(height: 40),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Congratulations!',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 20,
                              color: Colors.orange),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Your account has been succesfully created!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 16,
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
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              'Back to login',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                            )),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
