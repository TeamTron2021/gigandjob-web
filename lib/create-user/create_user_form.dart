import 'package:flutter/material.dart';

class CreateUserForm extends StatelessWidget {
  const CreateUserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Center(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'FirstName'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'LastName'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Birthdate'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColorDark,
                  fixedSize: Size(150, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
