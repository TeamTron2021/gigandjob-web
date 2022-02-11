// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gigandjob_web/main.dart';
import 'package:gigandjob_web/user-list/user_list_model.dart';
import 'package:gigandjob_web/user-list/user_list_repository.dart';
import 'package:gigandjob_web/user-list/user_list_screen.dart';

void main() {
  testWidgets("Option button reactive on user list",
      (WidgetTester tester) async {
    final widget =
        OptionButtonSuspendComponent(suspend: true, onPressed: () {});

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

    var txtBtn = find.text("Reactive");
    expect(txtBtn, findsOneWidget);
  });

  testWidgets("Option button reactive on user list",
      (WidgetTester tester) async {
    final widget =
        OptionButtonSuspendComponent(suspend: false, onPressed: () {});

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

    var txtBtn = find.text("Suspend");
    expect(txtBtn, findsOneWidget);
  });
}
