import 'package:flutter/material.dart';
import '../components/gameappbar.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getGameAppBar(context),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Flexible(
          child: Image.network(
              "images/esports-logo-template-for-sports-gaming-teams-1874d.png")),
    );
  }
}
