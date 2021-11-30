import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:histo_view/model/user.dart';
import 'package:histo_view/viewModel/profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({Key? key}) : super(key: key);

  final viewModel = ProfileViewModel();
  final _user = User();

  final _profileFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _presentationController = TextEditingController();

  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Plese enter a valid email'),
  ]);

  @override
  Widget build(BuildContext context) {
    _emailController.text = _user.email;
    _userNameController.text = _user.userName;
    _presentationController.text = _user.presentation;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _profileFormKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.done,
                      color: Colors.orange,
                      size: 35,
                    ),
                    onPressed: () {
                      if (_profileFormKey.currentState!.validate()) {
                        // checks if any field has been modified
                        if (_user.userName != _userNameController.text ||
                            _user.email != _emailController.text ||
                            _user.presentation !=
                                _presentationController.text) {
                          _user.userName = _userNameController.text;
                          _user.email = _emailController.text;
                          _user.presentation = _presentationController.text;
                          //updates user's profile
                          viewModel.updateUserProfile(_user);
                        }
                        Navigator.pushNamed(context, '/tabBar', arguments: 2);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Icon(
                Icons.person,
                size: 100,
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Text(
                  "Change profile's photo",
                  style: TextStyle(color: Colors.orange, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //Name
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Name',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      color: Colors.grey.shade700),
                ),
              ),
              TextFormField(
                validator: RequiredValidator(errorText: 'Name is required'),
                controller: _userNameController,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(
                height: 25,
              ),
              //Email
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      color: Colors.grey.shade700),
                ),
              ),
              TextFormField(
                validator: _emailValidator,
                controller: _emailController,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(
                height: 25,
              ),
              //Presentation
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Presentation',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      color: Colors.grey.shade700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator:
                    RequiredValidator(errorText: 'Presentation is required'),
                controller: _presentationController,
                minLines: 10,
                maxLines: 10,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
