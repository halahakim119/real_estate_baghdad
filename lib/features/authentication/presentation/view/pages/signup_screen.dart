import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/router.gr.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../logic/bloc/authentication_bloc.dart';
import 'verification_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneNumberController =
      TextEditingController(text: '+964');

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;

  bool _isConfirmPasswordVisible = false;
  final TextColor = const Color.fromARGB(255, 181, 156, 138);

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context)
        ..add(
          SignUpWithPhoneRequested(
            name: _nameController.text.trim(),
            phoneNumber: _phoneNumberController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 35, 47, 103), size: 18),
          backgroundColor: Colors.white,
          toolbarHeight: 40,
          elevation: 0,
          title: const AutoSizeText(
            "Sign up",
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 35, 47, 103),
              fontFamily: 'Lily_Script_One',
            ),
          ),
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Signup Error'),
                    content: const Text("please enter valid data"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else if (state is VerifyPhoneNumber) {
              print(state.verificationCode);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VeificationScreen(
                    verificationCode: state.verificationCode,
                    code: state.code,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/house_signup.png',
                        height: 160,
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        labelText: 'Name',
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        controller: _nameController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        keyboardType: TextInputType.phone,
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
                        controller: _phoneNumberController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        labelText: 'Password',
                        onChanged: (value) {
                          // Handle confirm password change here
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ' password is required';
                          }

                          return null;
                        },
                        obscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        labelText: 'Confirm Password',
                        onChanged: (value) {
                          // Handle confirm password change here
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm password is required';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        obscureText: !_isConfirmPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        controller: _confirmPasswordController,
                      ),
                      const SizedBox(height: 24),
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
                              'Sign Up',
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
                              'Already have an account? ',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.router.popAndPush(const LoginRoute());
                              },
                              child: AutoSizeText(
                                'Login',
                                style: TextStyle(
                                  color: TextColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
