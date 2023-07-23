import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  late String category;
  late int rank;
  late DocumentReference _manager;
  final DocumentSnapshot teamDoc;

  Team(this.teamDoc) {
    final data = teamDoc.data() as Map<String, dynamic>;
    category = data['category'];
    rank = data['rank'];
    _manager = data['manager'];
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPlayers() {
    return teamDoc.reference.collection('Players').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGames() {
    return teamDoc.reference.collection('Games').snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getManager() {
    return _manager.snapshots();
  }
}
