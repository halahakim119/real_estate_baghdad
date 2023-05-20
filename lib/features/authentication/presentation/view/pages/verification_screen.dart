import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/router.gr.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../logic/bloc/authentication_bloc.dart';

class VeificationScreen extends StatelessWidget {
  final String code;
  final String verificationCode;

  const VeificationScreen({
    Key? key,
    required this.code,
    required this.verificationCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: _VeificationScreenContent(
        code: code,
        verificationCode: verificationCode,
      ),
    );
  }
}

class _VeificationScreenContent extends StatefulWidget {
  final String code;
  final String verificationCode;

  const _VeificationScreenContent({
    Key? key,
    required this.code,
    required this.verificationCode,
  }) : super(key: key);

  @override
  _VeificationScreenContentState createState() =>
      _VeificationScreenContentState();
}
class _VeificationScreenContentState extends State<_VeificationScreenContent> {
  final _formKey = GlobalKey<FormState>();
  late String _verificationCode;
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is VerifyPhoneNumberSuccess) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Success'),
                  content: const Text("Your account is ready to be used"),
                  actions: [
                    TextButton(
                      onPressed: () {
                          context.router.popAndPush(const LoginRoute());
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          
          }
          else if (state is VerifyPhoneNumberFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text("Incorrect Verification Code"),
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
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  keyboardType: TextInputType.number,
                  labelText: 'Verification Code',
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Verification Code is required';
                    }
                    return null;
                  },
                  onSaved: (value) => _verificationCode = value!,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _authenticationBloc.add(
                        VerifyPhoneSignUpRequested(
                          code: widget.code,
                          verificationCode: _verificationCode,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 47, 103),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
