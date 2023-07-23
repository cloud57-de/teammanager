import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../screens/profile.dart';
import '../screens/signin.dart';

AppBar getGameAppBar(BuildContext context) {
  return AppBar(
    leading: const IconButton(
      icon: Icon(Icons.menu),
      tooltip: 'Navigation menu',
      onPressed: null,
    ),
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: const Expanded(child: Center(child: Text('Cloud57 Teammanager'))),
    actions: [
      _loginState(context),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserAvatar(
          auth: FirebaseAuth.instance,
          size: 32.0,
        ),
      ),
    ],
  );
}

Widget _loginState(BuildContext context) {
  return FirebaseAuth.instance.currentUser != null
      ? IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => profileScreen),
          ),
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
        )
      : IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => signInScreen),
          ),
          icon: const Icon(Icons.login),
          tooltip: 'Login',
        );
}
