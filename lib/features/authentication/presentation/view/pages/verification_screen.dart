import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:real_estate_baghdad/features/users/presentation/logic/bloc/user_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/router.gr.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../../../users/data/models/user_model.dart';
import '../../logic/bloc/authentication_bloc.dart';

class VeificationScreen extends StatelessWidget {
  final String code;
  final String verificationCode;
  final String? typeForm;

  const VeificationScreen(
      {Key? key,
      required this.code,
      required this.verificationCode,
      this.typeForm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: _VeificationScreenContent(
        code: code,
        verificationCode: verificationCode,
        typeForm: typeForm,
      ),
    );
  }
}

class _VeificationScreenContent extends StatefulWidget {
  final String code;
  final String verificationCode;
  final String? typeForm;

  const _VeificationScreenContent(
      {Key? key,
      required this.code,
      required this.verificationCode,
      this.typeForm})
      : super(key: key);

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

    getUserData();
    userBox.listenable().addListener(_onBoxChange);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);

    super.dispose();
  }

  void _onBoxChange() {
    setState(() {
      getUserData();
    });
  }

  UserModel? user;
  final userBox = Hive.box<UserModel>('userBox');

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 35, 47, 103), size: 18),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          toolbarHeight: 40,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(UniconsLine.angle_left_b),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: widget.typeForm == null
            ? BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is VerifyPhoneNumberSuccess) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content:
                              const Text("Your account is ready to be used"),
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
                  } else if (state is VerifyPhoneNumberFailure) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: Text(state.errorMessage),
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
              )
            : BlocProvider(
                create: (context) => sl<UserBloc>(),
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is PhoneNumberUpdated) {
                      context.router.pop();
                    }
                    if (state is UserError) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text(state.message),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return Padding(
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
                                  final updatePhoneNumberEvent =
                                      UpdatePhoneNumberEvent(
                                    widget.code,
                                    _verificationCode,
                                  );
                                  context
                                      .read<UserBloc>()
                                      .add(updatePhoneNumberEvent);
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
                    );
                  },
                ),
              ));
  }
}
