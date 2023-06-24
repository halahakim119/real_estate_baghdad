import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/injection/injection_container.dart';
import '../../core/router/router.gr.dart';
import '../users/presentation/logic/bloc/user_bloc.dart';

import '../users/data/models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;

  const EditProfileScreen({required this.name, required this.phoneNumber});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isEditName = false;
  final nameController = TextEditingController();

  bool isEditPhoneNumber = false;
  final phoneNumberController = TextEditingController();

  UserModel? user;
  final userBox = Hive.box<UserModel>('userBox');

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    phoneNumberController.text = widget.phoneNumber;
    getUserData();
    userBox.listenable().addListener(_onBoxChange);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }

  void _onBoxChange() {
    setState(() {
      getUserData();
    });
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  void cancelNameEditing() {
    setState(() {
      isEditName = false;
      nameController.text =
          widget.name; // Reset the name value to the original value
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<UserBloc>(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Edit Personal Information')),
          body: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserError) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Fail'),
                      content: Text(state.message),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is UserEdited) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Success'),
                      content: Text(state.message),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is PhoneNumberVerified) {
                print(state.verificationCode);
                context.router.push(VeificationRoute(
                    verificationCode: state.verificationCode,
                    code: state.code,
                    typeForm: 'editPhoneNumer'));
              } else if (state is PhoneNumberUpdated) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Success'),
                      content: Text(state.message),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.router.pop();
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
              if (state is UserLoading) {
                return const CircularProgressIndicator();
              }
              return Column(children: [
                isEditName == false
                    ? ListTile(
                        title: Text(widget.name),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              isEditName = true;
                            });
                          },
                          icon: const Icon(Icons.edit),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 0),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 0.5,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    final newName = nameController.text;
                                    final userId = user!.id;
                                    final token = user!.token;

                                    final editUserEvent =
                                        EditUserEvent(userId, token!, newName);
                                    context.read<UserBloc>().add(editUserEvent);

                                    isEditName = false;
                                  });
                                },
                                icon: const Icon(Icons.check),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: cancelNameEditing,
                            icon: const Icon(Icons.cancel_outlined),
                            color: Theme.of(context).colorScheme.error,
                          )
                        ],
                      ),
                const Divider(
                  thickness: 0.3,
                  color: Color.fromARGB(255, 35, 47, 103),
                ),
                isEditPhoneNumber == false
                    ? ListTile(
                        title: Text(widget.phoneNumber),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              isEditPhoneNumber = true;
                            });
                          },
                          icon: const Icon(Icons.edit),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : ListTile(
                        title: TextField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 0.5,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              final newPhoneNumber = phoneNumberController.text;
                              final userId = user!.id;
                              final token = user!.token;

                              final verifyPhoneNumberEvent =
                                  VerifyPhoneNumberEvent(
                                      userId, newPhoneNumber, token!);
                              context
                                  .read<UserBloc>()
                                  .add(verifyPhoneNumberEvent);

                              isEditPhoneNumber = false;
                            });
                          },
                          icon: const Icon(Icons.check),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                const Divider(
                  thickness: 0.3,
                  color: Color.fromARGB(255, 35, 47, 103),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
