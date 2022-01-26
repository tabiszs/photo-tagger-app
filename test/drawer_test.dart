import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_tagger/data/service/auth_service.dart';
import './firebase_auth_mock.dart'; // from: https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/test/mock.dart

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Drawer Test', (WidgetTester tester) async {
    final AuthService authService =
        AuthService(firebaseAuth: FirebaseAuth.instance);
    User? user = authService.currentUser;

    user?.updateDisplayName('Bob');

    //expect(find.noSuchMethod(Invocation invocation) {
    //  return invocation == null;
    //}, user!.displayName);

// TODO - test too long strings
//   final name = 'Jan Kowalski Maria Winae';
//  final email = 'jk@wp.pl-asssssssssssssssaaaaaaaa';

    Map<String, String?> _data = {
      'displayName': 'Jan Kowalski',
      'email': 'jan.kowaliski@gmail.com',
      'photoURL': 'xxx'
    };
    UserInfo userInfo = new UserInfo(_data);
  });
}
