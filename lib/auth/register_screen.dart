import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/widges/default_elevated_button.dart';
import 'package:evently/widges/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routename = '/registerScreen';

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 16,
                ),
                DefaultTextFormField(
                  controller: nameController,
                  hintText: 'Name',
                  prefixIconImageName: 'name',
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "invalid name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                DefaultTextFormField(
                  controller: emailController,
                  hintText: 'Email',
                  prefixIconImageName: 'email',
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return "invalid Email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                DefaultTextFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  prefixIconImageName: 'password',
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return "password can not be less than 8 characters";
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                SizedBox(
                  height: 24,
                ),
                DefaultElevatedButton(lable: 'Register', onPressed: register),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(LoginScreen.routename),
                      child: Text('Login'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseService.register(
              name: nameController.text.trim(),
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then(
        (user) {
          Provider.of<UserProvider>(context, listen: false)
              .updateCurrentUser(user);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
        },
      ).catchError(
        (error) {
          print(error);
        },
      );
    }
  }
}
