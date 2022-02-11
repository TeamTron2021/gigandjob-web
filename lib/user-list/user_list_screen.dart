import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/user-list/user_list_bloc.dart';
import 'package:gigandjob_web/user-list/user_list_model.dart';
import 'package:gigandjob_web/user-list/user_list_repository.dart';

class OptionButtonSuspendComponent extends StatelessWidget {
  final bool suspend;
  final onPressed;
  const OptionButtonSuspendComponent(
      {Key? key, required this.suspend, required this.onPressed})
      : super(key: key);

  Widget build(BuildContext context) {
    if (suspend) {
      return ElevatedButton(
        onPressed: onPressed,
        child: const Text("Reactive"),
        style: ElevatedButton.styleFrom(
          primary: Colors.blueAccent,
        ),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text("Suspend"),
      style: ElevatedButton.styleFrom(
        primary: Colors.orangeAccent,
      ),
    );
  }
}

class _UserListScreen extends StatelessWidget {
  const _UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserListCubit>(context);
    bloc.getUsers();
    return BlocBuilder<UserListCubit, UserListCubitState>(
        bloc: bloc,
        builder: (context, state) => Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Center(
                          child: Text(
                        'User List',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                      const Divider(
                        color: Colors.white,
                      ),
                      ...state.model.expand((user) => [
                            Padding(
                              padding: const EdgeInsets.all(18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Text(
                                        user.firstname + ' ' + user.lastname,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )),
                                      Text(user.email),
                                      Text(user.id)
                                    ],
                                  ),
                                  OptionButtonSuspendComponent(
                                      suspend: user.status == "Supended",
                                      onPressed: user.status == "Supended"
                                          ? () {
                                              bloc.reactivateUser(user);
                                              print(user);
                                            }
                                          : () => bloc.suspendUser(user))
                                ],
                              ),
                            ),
                            const Divider(
                              indent: 20,
                              endIndent: 0,
                              color: Colors.white,
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<UserListRepository>(context);
    return BlocProvider<UserListCubit>(
        create: (_) => UserListCubit(repository: repository),
        child: _UserListScreen());
  }
}
