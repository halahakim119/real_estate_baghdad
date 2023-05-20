import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/router.gr.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../logic/bloc/authentication_bloc.dart';

// Define the SignupScreen widget as a StatefulWidget
class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

// Define the state for the SignupScreen widget
class _SignupScreenState extends State<SignupScreen> {
  // Create a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Create controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '+964');
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Define boolean variables for password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Function to submit the form
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Dispatch an event to the AuthenticationBloc to sign up with the provided data
      BlocProvider.of<AuthenticationBloc>(context).add(
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
        
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          // Listen for changes in the AuthenticationBloc state
          listener: (context, state) {
            if (state is AuthenticationSignupFailure) {
              // Show an error dialog if sign up fails
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Signup Error'),
                    content: const Text("Please enter valid data"),
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
              // Navigate to the verification screen if phone number verification is required
              print(state.verificationCode);
              context.router.push(VeificationRoute(
                verificationCode: state.verificationCode,
                code: state.code,
              ));
            }
          },
          // Build the UI based on the AuthenticationBloc state
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
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
                      _buildNameTextField(),
                      const SizedBox(height: 16),
                      _buildPhoneNumberTextField(),
                      const SizedBox(height: 16),
                      _buildPasswordTextField(),
                      const SizedBox(height: 16),
                      _buildConfirmPasswordTextField(),
                      const SizedBox(height: 24),
                      _buildSignUpButton(context),
                      const SizedBox(height: 16.0),
                      _buildLoginSection(context),
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

  // Build the name text field widget
  Widget _buildNameTextField() {
    return CustomTextField(
      labelText: 'Name',
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      controller: _nameController,
    );
  }

  // Build the phone number text field widget
  Widget _buildPhoneNumberTextField() {
    return CustomTextField(
      keyboardType: TextInputType.phone,
      labelText: 'Phone Number',
      onChanged: (value) {
        final enteredNumber = value.trim();
        final phoneNumber = '+964${enteredNumber.substring(4)}';
        _phoneNumberController.value = _phoneNumberController.value.copyWith(
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
    );
  }

  // Build the password text field widget
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
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      ),
      controller: _passwordController,
    );
  }

  // Build the confirm password text field widget
  Widget _buildConfirmPasswordTextField() {
    return CustomTextField(
      labelText: 'Confirm Password',
      onChanged: (value) {},
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
          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
          });
        },
      ),
      controller: _confirmPasswordController,
    );
  }

  // Build the sign up button widget
  Widget _buildSignUpButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _submitForm(context),
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 35, 47, 103),
          borderRadius: BorderRadius.all(Radius.circular(50)),
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
    );
  }

  // Build the login section widget
  Widget _buildLoginSection(BuildContext context) {
    return Center(
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
              // Navigate to the login screen
              context.router.popAndPush(const LoginRoute());
            },
            child: const AutoSizeText(
              'Login',
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

  // Check if a string is numeric
  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
