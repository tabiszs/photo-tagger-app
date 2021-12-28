import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_tagger/pages/drawer.dart';

void main() {
  testWidgets('Display account data', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Map<String, String?> _data = {
      'displayName': 'Jan Kowalski',
      'email': 'jan.kowaliski@gmail.com',
      'photoURL': 'xxx'
    };
    UserInfo userInfo = new UserInfo(_data);
    //await tester.pumpWidget(const NavDrawer());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
