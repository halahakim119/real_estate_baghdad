import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_baghdad/features/authentication/presentation/view/pages/reset_password_screen.dart';
import 'package:unicons/unicons.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../logic/bloc/authentication_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '+964');

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
          iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 35, 47, 103), size: 18),
          backgroundColor: Colors.white,
          toolbarHeight: 40,
          elevation: 0,
          title: const Text(
            'forgot Password',
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
                  CustomTextField(
                    labelText: 'Phone Number',
                    keyboardType: TextInputType.phone,
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
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () => _submitForm(context),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        color: Color.fromARGB(255, 35, 47, 103),
                      ),
                    ),
                  ),
                ],
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