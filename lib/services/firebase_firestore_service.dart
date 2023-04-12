import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:votekaro/services/firebase_authentication_service.dart';

// Collection Name: users
// Field: ['E-mail', 'Vote']
class FirebaseFirestoreService {
  final CollectionReference _user =
      FirebaseFirestore.instance.collection("users");

  // Adds a user's vote to the database
  Future<void> addUserVote(String? email, String vote) async {
    return _user
        .add({"E-mail": email, "Vote": vote})
        .then((value) => null)
        .catchError((onError) => null);
  }

  // Fetches all the data in the "users" collection in Firestore
  Future<List<dynamic>> fetchData() async {
    List elements = [];
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<dynamic> data = querySnapshot.docs.toList();
      elements = data;
    });
    return elements;
  }

  // Fetches the current user's vote from Firestore
  Future<String?> fetchUserVote() async {
    String? votedTeam;
    String currentUser =
        FirebaseAuthenticationService().getUserEmail().toString();
    List<dynamic> elements = await fetchData();
    for (var element in elements) {
      if (currentUser == element["E-mail"]) {
        votedTeam = element["Vote"];
      }
    }
    return votedTeam;
  }

  // Fetches the count of votes for each team
  Future<Map<String, int>> fetchVoteData() async {
    Map<String, int> teamVoteCount = {
      "csk": 0,
      "dc": 0,
      "gt": 0,
      "kkr": 0,
      "lsg": 0,
      "mi": 0,
      "pk": 0,
      "rcb": 0,
      "rr": 0,
      "srh": 0
    };
    List elements = await fetchData();
    // List<String> teamVotes = List.empty(growable: true);
    for (var element in elements) {
      if (teamVoteCount.containsKey(element["Vote"])) {
        teamVoteCount[element["Vote"]] = teamVoteCount[element["Vote"]]! + 1;
      }
    }
    return teamVoteCount;
  }
}
