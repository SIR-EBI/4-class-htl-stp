import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:listify_app/database/database_account_manager.dart';
import 'package:listify_app/default/custom_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;
  final _formKey = GlobalKey<FormState>();

  bool _validateEmail(String? email) {
    email = email!.trim();
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(pattern);

    if (email.isEmpty || !regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  bool _validatePassword(String? password) {
    password = password!.trim();
    if (password.isEmpty) {
      return false;
    }
    return true;
  }

  bool _validatePasswordConfirmed(String? password, String? passwordConfirmed) {
    password = password!.trim();
    passwordConfirmed = passwordConfirmed!.trim();
    if (password != passwordConfirmed ||
        (password.length == 0 && passwordConfirmed.length == 0)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.dark2,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /**
             * header text
             */
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 80.0,
                  left: 40.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Create a new account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /**
             * form container
             */
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /**
                   * email text field
                   */
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffe0e5ec),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(-4, -4),
                          blurRadius: 4,
                          color: Colors.white,
                          inset: true,
                        ),
                        BoxShadow(
                          offset: Offset(4, 4),
                          blurRadius: 4,
                          color: Color(0xffa3b1c6),
                          inset: true,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (!_validateEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Colors.black45,
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  /**
                   * spacer
                   */
                  const SizedBox(
                    height: 20.0,
                  ),
                  /**
                   * password text field
                   */
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffe0e5ec),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(-4, -4),
                          blurRadius: 4,
                          color: Colors.white,
                          inset: true,
                        ),
                        BoxShadow(
                          offset: Offset(4, 4),
                          blurRadius: 4,
                          color: Color(0xffa3b1c6),
                          inset: true,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (!_validatePassword(value)) {
                          return 'Please enter a longer password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: Colors.black45,
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  /**
                   * spacer
                   */
                  const SizedBox(
                    height: 20.0,
                  ),
                  /**
                   * confirm password text field
                   */
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffe0e5ec),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(-4, -4),
                          blurRadius: 4,
                          color: Colors.white,
                          inset: true,
                        ),
                        BoxShadow(
                          offset: Offset(4, 4),
                          blurRadius: 4,
                          color: Color(0xffa3b1c6),
                          inset: true,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (!_validatePasswordConfirmed(
                            passwordController.text, value)) {
                          return 'Password is not equal to confirmed password';
                        }
                        return null;
                      },
                      controller: passwordConfirmController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: !_passwordConfirmVisible,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: Colors.black45,
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordConfirmVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordConfirmVisible =
                                  !_passwordConfirmVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  /**
                   * submit button
                   */
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    height: 50,
                    width: 130,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: CustomColor.blue1,
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String? id =
                              await DatabaseAccountManager.createAccount(
                            "Name",
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('accountId', id!);
                          Navigator.popAndPushNamed(context, '/listScreen');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            /**
             * footer text
             */
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have a account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: CustomColor.blue1,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/signInScreen");
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
