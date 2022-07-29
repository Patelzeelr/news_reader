import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/methods/validation.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/custom_bottom_button.dart';
import '../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  TabController? controller;
  SignUpScreen(this.controller, {Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool value = false;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  void _addUser() {
    Map<String, dynamic> userData = {
      'name': userNameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      'phone': phoneController.text.trim()
    };
    _firestore.collection('user').doc(emailController.text).set(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFc0c0c0),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          height: 600,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0),
              topRight: Radius.circular(35.0),
              bottomLeft: Radius.circular(35.0),
              bottomRight: Radius.circular(35.0),
            ),
          ),
          child: SingleChildScrollView(
            child: _signUpCardDetail(),
          ),
        ),
      ),
      bottomNavigationBar: customBottomButton(
        'SIGN UP',
        _registerUser,
      ),
    );
  }

  _signUpCardDetail() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _signUpHeader(),
          _userNameTextField(),
          _emailTextField(),
          _phoneTextField(),
          _passwordTextField(),
          _termsAndCondition(),
          _loginText(),
        ],
      );

  _registerUser() async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      _addUser();
      if (newUser != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  _signUpHeader() => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Create an \nAccount',
          style: TextStyle(
            color: Colors.red,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  _userNameTextField() => Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: customTextFormField(userNameController, 'Name', 'John',
            Icons.account_circle, validateUsername, false),
      );

  _emailTextField() => Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: customTextFormField(emailController, 'Email',
            'example@gmail.com', Icons.email, validateEmail, false),
      );

  _phoneTextField() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: customTextFormField(phoneController, 'Phone no', '9035647829',
            Icons.phone, validatePassword, false),
      );

  _passwordTextField() => Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: customTextFormField(passwordController, 'Password', 'Password',
            Icons.lock, validatePassword, true),
      );

  _termsAndCondition() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Checkbox(
              side: const BorderSide(color: Colors.red, width: 2.0),
              value: value,
              onChanged: (bool? value) {
                setState(() {
                  this.value = value!;
                });
              },
              activeColor: Colors.red,
            ),
            RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'I agree with  ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'term & condition',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _loginText() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              widget.controller!.animateTo(0);
            },
            child: RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Already have an Account?',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' ' + 'Sign In!',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
