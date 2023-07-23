import 'package:cloud57_teammanager/model/player.dart';
import 'package:cloud57_teammanager/model/team.dart';
import 'package:cloud57_teammanager/screens/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/game.dart';

class GameList extends StatelessWidget {
  final Player player;

  const GameList.player(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: player.getTeam(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              Team team = Team(snapshot.data!);
              return getTeamStreamBuilder(team);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> getTeamStreamBuilder(Team team) {
    return StreamBuilder<QuerySnapshot>(
      stream: team.getGames(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return SelectableText('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        return getGameListView(documents, team);
      },
    );
  }

  ListView getGameListView(
      List<DocumentSnapshot<Object?>> documents, Team team) {
    return ListView.builder(
      itemCount: documents.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          String headingText = "Spielübersicht ${team.rank}. ${team.category}";
          return Center(
            child: Text(headingText),
          );
        } else if (index == 1) {
          return const Divider();
        } else {
          final DocumentSnapshot doc = documents[index - 2];
          var game = Game(doc, team);
          return _getListItems(game, doc);
        }
      },
    );
  }

  SelectionArea _getListItems(Game game, DocumentSnapshot<Object?> doc) {
    return SelectionArea(
      child: FutureBuilder(
        future: game.getPlayerCount(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _tile(context, game, snapshot.data!.count);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  ListTile _tile(BuildContext context, Game game, int playerCount) {
    IconData iconData = game.homePlay ? Icons.home : Icons.work_outline;
    Color color = Colors.black;

    if (playerCount < 2) {
      color = Colors.red;
    } else if (playerCount < 3) {
      color = Colors.yellow;
    }
    return ListTile(
      leading: Icon(iconData),
      title: Text("${game.startDateAsString()}: ${game.guestTeam}"),
      subtitle: Text("Bestätigte Spieler: $playerCount"),
      textColor: color,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameScreen(game: game)),
      ),
    );
  }
}
