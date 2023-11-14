import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:listify_app/database/database_account_manager.dart';
import 'package:listify_app/default/custom_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _passwordVisible = false;

  void showInvalidLoginAlert() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Login'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Invalid Login Data!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.dark2,
      resizeToAvoidBottomInset: false,
      body: Form(
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
                      "Welcome!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign in to continue",
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
                    child: TextField(
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
                    child: TextField(
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
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {

                          String? id = await DatabaseAccountManager.getIdOfAccount(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );

                          if (id != null) {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString('accountId', id);
                            Navigator.popAndPushNamed(context, '/listScreen');
                          } else {
                            showInvalidLoginAlert();
                          }

                        }),
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
                    "Don't hava an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: CustomColor.blue1,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/signUpScreen");
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
