import 'package:cloud57_teammanager/screens/signin.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../services/providers.dart';

final ProfileScreen profileScreen = ProfileScreen(
  providers: providers,
  actions: [
    SignedOutAction((context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => signInScreen),
      );
    }),
  ],
);
