import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/create-user/create_user_bloc.dart';
import 'package:gigandjob_web/create-user/create_user_repository.dart';

class _CreateUserScreen extends StatelessWidget {
  final GlobalKey<FormState> formState = GlobalKey();
  _CreateUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CreateUserCubit>(context);

    final firstnameController = TextEditingController();
    final lastnameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final birthdateController = TextEditingController();

    firstnameController.addListener(() {
      bloc.update(cb: (model) {
        model.firstname = firstnameController.text;
      });
    });
    lastnameController.addListener(() {
      bloc.update(cb: (model) {
        model.lastname = lastnameController.text;
      });
    });
    emailController.addListener(() {
      bloc.update(cb: (model) {
        model.email = emailController.text;
      });
    });
    passwordController.addListener(() {
      bloc.update(cb: (model) {
        model.password = passwordController.text;
      });
    });
    bloc.update();

    return BlocBuilder<CreateUserCubit, CreateUserCubitState>(
      bloc: bloc,
      builder: (context, state) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Center(
                  child: Text(
                'Create an User',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
              const Divider(
                color: Colors.white,
              ),
              Form(
                key: formState,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'FirstName'),
                          validator: (_) => state.errors["firstname"],
                          controller: firstnameController,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'LastName'),
                          validator: (_) => state.errors["lastname"],
                          controller: lastnameController,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Birthdate'),
                          readOnly: true,
                          validator: (_) => state.errors["birthdate"],
                          onTap: () async {
                            final DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: state.model.birthdate,
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 2022 * 365)),
                                lastDate: DateTime.now()
                                    .subtract(const Duration(days: 1)));
                            if (selectedDate != null) {
                              bloc.update(cb: (model) {
                                model.birthdate = selectedDate;
                              });
                              birthdateController.text =
                                  "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                            }
                            ;
                          },
                          controller: birthdateController,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (_) => state.errors["email"],
                          controller: emailController,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (_) => state.errors["password"],
                          controller: passwordController,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton.icon(
                        label: const Text(
                          'Send',
                          style: TextStyle(fontSize: 20),
                        ),
                        icon: const Icon(Icons.send),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColorDark,
                            fixedSize: const Size(150, 50)),
                        onPressed: () async {
                          if (formState.currentState!.validate()) {
                            await bloc.save();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen() : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateUserCubit>(
      create: (context) => CreateUserCubit(
          repository: RepositoryProvider.of<CreateUserRepository>(context)),
      child: _CreateUserScreen(),
    );
  }
}
