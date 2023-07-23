import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

final List<AuthProvider<AuthListener, AuthCredential>> providers = [
  EmailAuthProvider(),
  GoogleProvider(
      clientId:
          "941413641151-fbqnn9g6qeano8o8fieridng19atd2f8.apps.googleusercontent.com"),
];
