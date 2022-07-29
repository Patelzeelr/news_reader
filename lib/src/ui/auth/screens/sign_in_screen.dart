import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/firebase_service.dart';
import '../../../utils/methods/validation.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/custom_bottom_button.dart';
import '../widgets/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  TabController? controller;
  SignInScreen(this.controller, {Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isIndicate = false;

  final _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _isIndicate
        ? const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          )
        : Scaffold(
            backgroundColor: const Color(0xFFc0c0c0),
            body: Form(
              key: _formKey,
              child: Padding(
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
                    child: _signInCardDetail(),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: customBottomButton(
              'LOGIN',
              _loginUser,
            ),
          );
  }

  _signInCardDetail() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _signInHeader(),
          _emailTextField(),
          _passwordTextField(),
          _forgotPasswordText(),
          _socialMediaButton(),
          _registerText(),
        ],
      );

  _signInHeader() => const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'SignIn into your \nAccount',
          style: TextStyle(
            color: Colors.red,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  _emailTextField() => Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: customTextFormField(emailController, 'Email',
            'example@gmail.com', Icons.email, validateEmail, false),
      );

  _passwordTextField() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: customTextFormField(passwordController, 'Password', 'Password',
            Icons.lock, validatePassword, true),
      );

  _forgotPasswordText() => const Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  _socialMediaButton() => Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Login With',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _loginGoogle,
                  child: const Image(
                    image: AssetImage('assets/images/google.png'),
                    height: 40,
                    width: 40,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Image(
                    image: AssetImage('assets/images/facebook.png'),
                    height: 40,
                    width: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  _loginGoogle() async {
    FirebaseService service = FirebaseService();
    try {
      await service.signInwithGoogle();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      if (e is FirebaseAuthException) {
        print(e.message!);
      }
    }
  }

  _registerText() => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              widget.controller!.animateTo(1);
            },
            child: RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Don\'t have an Account?',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' ' + 'Register Now',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  _loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isIndicate = true;
      });
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        if (user != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', emailController.text);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
