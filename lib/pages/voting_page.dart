import 'package:flutter/material.dart';
import 'package:votekaro/pages/home_page.dart';
import 'package:votekaro/pages/result_page.dart';
import 'package:votekaro/services/firebase_firestore_service.dart';
import 'package:votekaro/services/firebase_authentication_service.dart';

// Voting Page Widget which extends the StatefulWidget
class VotingPage extends StatefulWidget {
  const VotingPage({Key? key}) : super(key: key);

  // Widget variables
  final Color _cardColor = Colors.white70;
  final Color _voteButtonTextColor = Colors.white;

  @override
  State<VotingPage> createState() => _VotingPageState();
}

// Voting Page State
class _VotingPageState extends State<VotingPage> {
  String? _votedTeam;

  // Widget variables
  Color _voteButtonColor = const Color.fromRGBO(33, 150, 243, 1);
  String _voteButtonText = 'Vote';

  // Team list
  final List<String> _teamNames = [
    "Chennai Super Kings",
    "Delhi Capitals",
    "Gujarat Titans",
    "Kolkata Knight Riders",
    "Lucknow Super Giants",
    "Mumbai Indians",
    "Punjab Kings",
    "Royal Challengers Bangalore",
    "Rajasthan Royals",
    "Sunrisers Hyderabad",
  ];
  final List<String> _teamLogos = [
    "images/csk.png",
    "images/dc.png",
    "images/gt.png",
    "images/kkr.png",
    "images/lsg.png",
    "images/mi.png",
    "images/pk.png",
    "images/rcb.png",
    "images/rr.png",
    "images/srh.png"
  ];

  // List of menu options
  final List<String> _menuOptions = ["Result", "Sign Out"];

  // Submitting vote
  void submitVote(String vote) {
    FirebaseFirestoreService()
        .addUserVote(FirebaseAuthenticationService().getUserEmail(), vote);
  }

  // Logging out user
  void _logOutUser() {
    FirebaseAuthenticationService().signOutUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  // Handling menu item selection
  void _onMenuItemSelect(item) {
    switch (item) {
      case "Result":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResultPage()));
        break;
      case "Sign Out":
        _logOutUser();
        break;
    }
  }

  // Voting function
  void _votedFunction(String? teamName) {
    setState(() {
      _votedTeam = teamName;
      _votedTeam = teamName;
      _voteButtonText = 'Voted';
      _voteButtonColor = Colors.purpleAccent;
    });
  }

  // Initializing state
  @override
  void initState() {
    super.initState();
    FirebaseFirestoreService().fetchUserVote().then((value) {
      if (value != null) _votedFunction(value);
    });
  }

  // Building widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
        appBar: AppBar(
          title: const Text('Voting Page'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            // Popup menu button
            PopupMenuButton<String>(
                onSelected: _onMenuItemSelect,
                itemBuilder: (BuildContext context) {
                  return _menuOptions.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                })
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.black),
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            thickness: 5,
            hoverThickness: 5,
            trackVisibility: true,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ListView.builder(
                  itemCount: _teamNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: widget._cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              height: 100,
                              width: 100,
                              image: AssetImage(_teamLogos[index].toString()),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Text(
                              _teamNames[index],
                              style: const TextStyle(fontSize: 20),
                            )),
                            _votedTeam != null &&
                                    _votedTeam.toString() !=
                                        _teamLogos[index]
                                            .substring(
                                                _teamLogos[index].indexOf("/") +
                                                    1,
                                                _teamLogos[index].indexOf("."))
                                            .toString()
                                ? const Text("")
                                : Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: _voteButtonColor,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_votedTeam == null) {
                                          submitVote(
                                            _teamLogos[index].substring(
                                                _teamLogos[index].indexOf("/") +
                                                    1,
                                                _teamLogos[index].indexOf(".")),
                                          );
                                          _votedFunction(_teamLogos[index]
                                              .substring(
                                                  _teamLogos[index]
                                                          .indexOf("/") +
                                                      1,
                                                  _teamLogos[index]
                                                      .indexOf(".")));
                                        }
                                      },
                                      child: Center(
                                          child: Text(
                                        _voteButtonText,
                                        style: TextStyle(
                                            color: widget._voteButtonTextColor,
                                            fontSize: 18),
                                      )),
                                    ))
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ));
  }
}
