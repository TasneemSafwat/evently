import 'package:evently/auth/register_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/widges/default_elevated_button.dart';
import 'package:evently/widges/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routename = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                DefaultElevatedButton(
                    lable: AppLocalizations.of(context)!.login,
                    onPressed: login),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(RegisterScreen.routename),
                      child: Text('Create Account'),
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

  void login() {
    if (formKey.currentState!.validate()) {
      FirebaseService.login(
              email: emailController.text, password: passwordController.text)
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
