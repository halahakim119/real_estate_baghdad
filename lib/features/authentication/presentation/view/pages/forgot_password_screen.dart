import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_baghdad/features/authentication/presentation/view/pages/reset_password_screen.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../logic/bloc/authentication_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();

  void _submitForm(BuildContext context) {
    final phoneNumber = _phoneNumberController.text.trim();
    BlocProvider.of<AuthenticationBloc>(context).add(
      ResetPasswordRequested(phoneNumber: phoneNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password'),
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is VerifyPhoneNumber) {
              print(state.verificationCode);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ResetPasswordScreen(
                    verificationCode: state.verificationCode,
                    code: state.code,
                    phoneNumber: _phoneNumberController.toString(),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _submitForm(context),
                    child: Text('Submit'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
