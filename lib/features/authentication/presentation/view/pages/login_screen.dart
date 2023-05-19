import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/router.gr.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../logic/bloc/authentication_bloc.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '+964');
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  final TextColor = const Color.fromARGB(255, 181, 156, 138);

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context)..add(
        SignInWithPhoneRequested(
          phoneNumber: _phoneNumberController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            "Login",
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 35, 47, 103),
              fontFamily: 'Lily_Script_One',
            ),
          ),
          iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 35, 47, 103), size: 18),
          backgroundColor: Colors.white,
          toolbarHeight: 40,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(UniconsLine.angle_left_b),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationFailure) {
              _showErrorDialog(context,
                  "There is no account with the existing phone number or maybe you entered wrong password");
            } else if (state is AuthenticationSigninSuccess) {
              print("success");
              // Navigator.pushNamed(context, '/dashboard');
            }
          },
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/sweet_home.png',
                      height: 160,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: 'Phone Number',
                      onChanged: (value) {
                        final enteredNumber = value.trim();
                        final phoneNumber =
                            '+964${enteredNumber.substring(4)}'; // Append the entered number excluding the prefix
                        _phoneNumberController.value =
                            _phoneNumberController.value.copyWith(
                          text: phoneNumber,
                          selection: TextSelection.collapsed(
                            offset: phoneNumber.length,
                          ),
                        );
                      },
                      validator: (value) {
                        if (value!.length <= 4) {
                          return 'Phone number is required';
                        }
                        if (value.length > 15) {
                          return 'Phone number should be 10 numbers only';
                        }
                        if (!isNumeric(value)) {
                          return 'Phone number must contain only numbers';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Password',
                      onChanged: (value) {
                        // Handle password change here
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      controller: _passwordController,
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _submitForm(context),
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 35, 47, 103),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: const Center(
                          child: AutoSizeText(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          const AutoSizeText(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.router.popAndPush(const SignupRoute());
                            },
                            child: AutoSizeText(
                              'Sign up',
                              style: TextStyle(
                                color: TextColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ForgotPasswordScreen()),
                        );
                      },
                      child: AutoSizeText(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 12,
                          color: TextColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
