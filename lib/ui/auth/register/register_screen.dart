
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/app_routes.dart';
import 'package:todo/core/utils/dialog_utils.dart';
import 'package:todo/core/utils/email_validation.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/ui/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmationController =
  TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blue.shade900,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/images/auth_logo.svg'),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: fullNameController,
                  hint: 'Full Name',
                  keyboardType: TextInputType.name,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter Full Name';
                    }
                    if (input is int) {
                      return 'Sorry, Invalid input';
                    }
                    return null;
                  },
                ),
                Text(
                  'User Name',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: userNameController,
                  hint: 'User Name',
                  keyboardType: TextInputType.name,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter User Name';
                    }
                    return null;
                  },
                ),
                Text(
                  'E-mail',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: emailController,
                  hint: 'E-mail Address',
                  keyboardType: TextInputType.emailAddress,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz enter e-mail address';
                    }
                    if (!isValidEmail(input)) {
                      return 'Email bad format';
                    }
                    return null;
                  },
                ),
                Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: passwordController,
                  hint: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  isSecureText: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz enter password';
                    }
                    if (input.length < 6) {
                      return 'Sorry, Password should be at least 6 chars';
                    }
                    return null;
                  },
                ),
                Text(
                  'Confirm Password',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: passwordConfirmationController,
                  hint: 're-password',
                  keyboardType: TextInputType.visiblePassword,
                  isSecureText: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz enter password';
                    }
                    if (input != passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {
                      createAccount(
                        emailController.text,
                        passwordController.text,
                        fullNameController.text,
                        userNameController.text,
                      );
                    },
                    child: Text('Register')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          //ToDo
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.loginRoute);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount(
      String email, String password, String fullName, String userName) async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    if (formKey.currentState?.validate() == false) {
      return;
    }

    // create account register user

    try {
      DialogUtils.showLoadingDialog(context, message: 'Create Account...');
      await authProvider.register(
          email: email,
          fullName: fullName,
          userName: userName,
          password: password);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          message: 'Registration Successfully',
          posActionTitle: 'Login', posAction: () {
            Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
          });
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'weak-password') {
        DialogUtils.showMessageDialog(context,
            message: 'The password provided is too weak.',
            posActionTitle: 'Try Again');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMessageDialog(context,
            message:
            'The account already exists for that email, try anothe account.',
            posActionTitle: 'Ok');
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          message: e.toString(), posActionTitle: 'Ok');
    }
  }
}