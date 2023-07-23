import 'package:cloud57_teammanager/model/team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Game {
  late bool homePlay;
  late String guestTeam;
  late Timestamp startDate;
  final DocumentSnapshot _gameDoc;
  final Team team;

  Game(this._gameDoc, this.team) {
    final data = _gameDoc.data() as Map<String, dynamic>;
    homePlay = data['home_play'];
    guestTeam = _gameDoc['team'];
    startDate = _gameDoc['start_date'];
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPlayers() {
    return _gameDoc.reference.collection('Players').snapshots();
  }

  Future<AggregateQuerySnapshot> getPlayerCount() {
    return _gameDoc.reference.collection('Players').count().get();
  }

  String startDateAsString() {
    return "${DateFormat.yMd('de_DE').format(DateTime.fromMillisecondsSinceEpoch(startDate.millisecondsSinceEpoch))} - ${DateFormat.Hms('de_DE').format(DateTime.fromMillisecondsSinceEpoch(startDate.millisecondsSinceEpoch))}";
  }
}
