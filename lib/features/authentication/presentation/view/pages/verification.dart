import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/aithentication_bloc.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String code;
  final String verificationCode;

  const VerifyPhoneScreen(
      {Key? key, required this.code, required this.verificationCode})
      : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
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
        title: Text('Verify Phone'),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            context.router.pushNamed('/');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Verification Code: ${widget.verificationCode}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Verification Code',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the verification code.';
                    }
                    return null;
                  },
                  onSaved: (value) => _verificationCode = value!,
                ),
                SizedBox(height: 16),
                ElevatedButton(
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
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
