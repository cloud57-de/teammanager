import 'package:cloud57_teammanager/components/game_player_list.dart';
import 'package:cloud57_teammanager/components/gameappbar.dart';
import 'package:cloud57_teammanager/components/team_player_list.dart';
import 'package:flutter/material.dart';

import '../model/game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getGameAppBar(context),
      body: Column(
        children: [
          Text("Spiel: ${game.guestTeam}"),
          Text("Datum: ${game.startDateAsString()}"),
          GamePlayerList.game(game),
          TeamPlayerList.team(game.team),
        ],
      ),
    );
  }
}
