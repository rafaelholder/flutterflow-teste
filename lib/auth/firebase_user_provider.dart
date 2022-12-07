import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TesteFirebaseFlutterflowFirebaseUser {
  TesteFirebaseFlutterflowFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

TesteFirebaseFlutterflowFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TesteFirebaseFlutterflowFirebaseUser>
    testeFirebaseFlutterflowFirebaseUserStream() => FirebaseAuth.instance
            .authStateChanges()
            .debounce((user) => user == null && !loggedIn
                ? TimerStream(true, const Duration(seconds: 1))
                : Stream.value(user))
            .map<TesteFirebaseFlutterflowFirebaseUser>(
          (user) {
            currentUser = TesteFirebaseFlutterflowFirebaseUser(user);
            return currentUser!;
          },
        );
