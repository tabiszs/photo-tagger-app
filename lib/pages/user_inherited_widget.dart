import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserInhertitedWidget extends InheritedWidget {
  const UserInhertitedWidget(
      {required Key key, required Widget child, this.user})
      : super(key: key, child: child);

  final User? user;

  @override
  bool updateShouldNotify(UserInhertitedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    print('In updateShouldNotify');
    return user != oldWidget.user;
  }
}
