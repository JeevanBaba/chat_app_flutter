import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // login function
  void login(BuildContext context) async {
    //auth service
    final auth = AuthenticationService();
    // try
    try {
      await auth.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    }
    //catch and error
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.chat,
              size: 60,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            SizedBox(height: 40),
            // welcome message
            Text(
              'Welcome to Chat App, please login to continue',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            // email input
            CustomTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),

            SizedBox(height: 20),
            // password input
            CustomTextField(
              hintText: 'Password',
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 20),
            // login button
            MyButton(text: 'LOGIN', onTap: () => login(context)),
            SizedBox(height: 20),

            // register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // persistentFooterButtons: [
      //   Center(child: Text('HEEEEELOOOOOOO TEXT CHECK')),
      // ],
    );
  }
}
