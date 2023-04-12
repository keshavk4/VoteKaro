import 'dart:async';
import 'package:flutter/material.dart';
import 'package:votekaro/services/firebase_firestore_service.dart';

// Class for the Result page of the e-voting app
class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  // Text color for the page
  final Color textColor = Colors.white;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

// State class for ResultPage
class _ResultPageState extends State<ResultPage> {
  // Properties for Timer and loading state
  late Timer _timer;
  bool _isLoading = true;

  // List for team names and a map for votes
  List _teamNames = [];
  late Map<String, int> _votes;

  // Function to fetch vote data from Firebase
  void getData() async {
    // Fetching vote data and assigning to _votes and _teamNames
    _votes = await FirebaseFirestoreService().fetchVoteData();
    _teamNames = _votes.keys.toList();

    // Setting loading state to false to show the data on the UI
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // Setting up a periodic Timer to fetch the data every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (callback) {
      // Checking if the widget is mounted before fetching the data
      if (mounted) getData();
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Canceling the Timer when the widget is disposed
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // List of team logos
    final List<String> teamLogos = [
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        centerTitle: true,
      ),

      // Showing a loading spinner or the result data based on _isLoading state
      body: _isLoading
          ? Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            )
          : Container(
              color: Colors.black,
              child: Scrollbar(
                // Building a ListView with separators for each team
                child: ListView.separated(
                    itemCount: _teamNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Building a Column with the team logo, name and votes count
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  color: Colors.grey,
                                  child: Image(
                                    height: 80,
                                    width: 80,
                                    image: AssetImage(
                                        teamLogos[index].toString()),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(_teamNames[index].toUpperCase(),
                                      style: TextStyle(
                                          color: widget.textColor,
                                          fontSize: 28)),
                                ),
                                Text(
                                  _votes[_teamNames[index]].toString(),
                                  style: TextStyle(
                                      color: widget.textColor, fontSize: 28),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                          color: Colors.white,
                          thickness: 2,
                        )),
              ),
            ),
    );
  }
}
