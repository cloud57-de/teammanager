import 'package:cloud57_teammanager/screens/home.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../services/providers.dart';

final SignInScreen signInScreen = SignInScreen(
  providers: providers,
  actions: [
    AuthStateChangeAction<SignedIn>((context, state) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const HomeScreen(title: 'Cloud57 Teammanager'),
          ));
    }),
  ],
);
