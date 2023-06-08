import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/router.gr.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../logic/bloc/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form key to identify and control the login form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller for the phone number text field
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '+964');

  // Controller for the password text field
  final TextEditingController _passwordController = TextEditingController();

  // Flag to toggle the visibility of the password
  bool _isPasswordVisible = false;

  // Submit the login form
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Dispatch the sign-in event with the entered phone number and password
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignInWithPhoneRequested(
          phoneNumber: _phoneNumberController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  // Show an error dialog with the provided error message
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
        
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          // Listen to authentication state changes
          listener: (context, state) {
            if (state is AuthenticationSigninFailure) {
              // Show error dialog if sign-in fails
              _showErrorDialog(
                context,
                "There is no account with the existing phone number or maybe you entered wrong password",
              );
            } else if (state is AuthenticationSigninSuccess) {
              // Navigate to the main screen if sign-in succeeds
              context.router.popAndPush( MainRoute());
            }
          },
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              // Show loading indicator if authentication is in progress
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
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
                      _buildPhoneNumberTextField(), // Phone number text field
                      const SizedBox(height: 16),
                      _buildPasswordTextField(), // Password text field
                      const SizedBox(height: 16),
                      _buildLoginButton(context), // Login button
                      const SizedBox(height: 16.0),
                      _buildSignupSection(context), // Sign up section
                      _buildForgotPasswordButton(context), // Forgot password button
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

  // Builds the phone number text field
  Widget _buildPhoneNumberTextField() {
    return CustomTextField(
      labelText: 'Phone Number',
      onChanged: (value) {
        final enteredNumber = value.trim();
        final phoneNumber = '+964${enteredNumber.substring(4)}';
        _phoneNumberController.value = _phoneNumberController.value.copyWith(
          text: phoneNumber,
          selection: TextSelection.collapsed(offset: phoneNumber.length),
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
    );
  }

  // Builds the password text field
  Widget _buildPasswordTextField() {
    return CustomTextField(
      labelText: 'Password',
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      obscureText: !_isPasswordVisible,
      suffixIcon: IconButton(
        icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          _isPasswordVisible = !_isPasswordVisible;
          setState(() {
            
          });
        },
      ),
      controller: _passwordController,
    );
  }

  // Builds the login button
  Widget _buildLoginButton(BuildContext context) {
    return GestureDetector(
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
        child:  Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }

  // Builds the sign-up section
  Widget _buildSignupSection(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          const Text(
            'Don\'t have an account? ',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              context.router.popAndPush(const SignupRoute());
            },
            child: const Text(
              'Sign up',
              style: TextStyle(
                color: Color.fromARGB(255, 181, 156, 138),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the forgot password button
  Widget _buildForgotPasswordButton(BuildContext context) {
    return TextButton(
      onPressed: () => context.router.push(const ForgotPasswordRoute()),
      child: const Text(
        'Forgot password?',
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 181, 156, 138),
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  // Checks if a string is numeric
  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
