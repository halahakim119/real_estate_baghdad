import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart' as di;
import '../../../../../core/injection/injection_container.dart';
import '../../logic/bloc/aithentication_bloc.dart';
import 'verification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(SignUpScreen());
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
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
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Sign Up'),
          ),
          body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationSuccess) {
             Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VerifyPhoneScreen(
                      verificationCode: state.verificationCode,
                      code: state.code,
                    ),
                  ),
                );
              } else if (state is VerifyPhoneNumber) {
                // Navigate to the verification screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VerifyPhoneScreen(
                      code: state.code,
                      verificationCode: state.verificationCode,
                    ),
                  ),
                );
              } else if (state is AuthenticationFailure) {
                // Show an error dialog if sign up fails
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Error'),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: state is AuthenticationLoading
                            ? null
                            : () => _submitForm(context),
                        child: state is AuthenticationLoading
                            ? CircularProgressIndicator()
                            : Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
