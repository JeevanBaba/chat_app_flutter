import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  //email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpwController = TextEditingController();

  // Tap to go to register page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //  register function
  void register(BuildContext context) async {
    // authentification service
    final auth = AuthenticationService();
    // password match -> create account
    if (_passwordController.text == _confirmpwController.text) {
      try {
        await auth.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
    // password do not match -> tell user to correct
    else {
      showDialog(
        context: context,
        builder:
            (context) =>
                AlertDialog(title: Text('Passwords is the not same same')),
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
              'Let\'s create an account for you',
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

            //  confirm password input
            CustomTextField(
              hintText: 'Confirm Password',
              obscureText: true,
              controller: _confirmpwController,
            ),

            SizedBox(height: 20),

            // register button
            MyButton(text: 'REGISTER', onTap: () => register(context)),
            SizedBox(height: 20),

            // register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Login Now',
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
    );
  }
}
