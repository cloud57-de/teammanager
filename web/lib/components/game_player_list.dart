import 'package:cloud57_teammanager/model/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/game.dart';

class GamePlayerList extends StatelessWidget {
  final Game game;

  const GamePlayerList.game(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Theme.of(context).canvasColor,
            padding: const EdgeInsets.all(8.0),
            child: const Text("Spieler")),
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: SizedBox(
            height: 200.0,
            child: StreamBuilder<QuerySnapshot>(
              stream: game.getPlayers(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return SelectableText('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot playerDoc = documents[index];

                    return SelectionArea(
                      child: FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('Player')
                              .doc(playerDoc.id)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Player player = Player(snapshot.data!);
                              return Text(
                                  "${player.firstName} ${player.lastName}");
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
