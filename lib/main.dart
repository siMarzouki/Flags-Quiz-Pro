import 'package:flutter/material.dart';
import './widgets/choice.dart';
import './countries.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flags Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  //store the best score
  int bestScore = 0;
  int score = 0;
  int answer;
  //best score key for shared preferences
  static const String bestScorekey = 'bestScore';

  //save the best score
  void saveNewBestScore(int value) async {
    //1
    final prefs = await SharedPreferences.getInstance();
    //2
    prefs.setInt(bestScorekey, value);
  }

  //getting the best score
  void getBestScore() async {
    //1
    final prefs = await SharedPreferences.getInstance();
    //2
    if (prefs.containsKey(bestScorekey)) {
      //3
      bestScore = prefs.getInt(bestScorekey);
    }
  }

  //if playing true : play
  //if playing false : earth logo + start btn
  bool playing = false;

  List<int> selectedCountries = [];
  int correctCountry;

  //checking the answer
  //if true : score++ and new question loaded
  //if false : back to start and compare the current score with the best one
  void checkAnswer() {
    if (answer == correctCountry) {
      setState(() {
        score++;
        prepareCountries();
      });
    } else {
      if (score > bestScore) {
        bestScore = score;

        ///add this here
        saveNewBestScore(score);
      }

      setState(() {
        playing = false;
      });
      prepareCountries();
    }
  }

  //prepare the 6 countries and select random one as a target country
  void prepareCountries() {
    selectedCountries = [];
    while (selectedCountries.length < 6) {
      int rand = Random().nextInt(countries.length);
      //checck for duplicate before adding
      if (!selectedCountries.contains(rand)) selectedCountries.add(rand);
    }
    correctCountry = Random().nextInt(6);
  }

  //prepare the countries and load best score in the initState
  @override
  void initState() {
    super.initState();
    prepareCountries();
    getBestScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flags Quiz"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.deepPurple, Colors.pink])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            playing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Choice(
                        country: countries[selectedCountries[0]]["Code"],
                        voidCallback: () {
                          //setting the answer by it reference in the selectedCountries array
                          //then checking it via checkAnswer()
                          answer = 0;
                          checkAnswer();
                        },
                      ),
                      Choice(
                        country: countries[selectedCountries[1]]["Code"],
                        voidCallback: () {
                          answer = 1;
                          checkAnswer();
                        },
                      ),
                    ],
                  )
                : Container(),
            playing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Choice(
                        country: countries[selectedCountries[2]]["Code"],
                        voidCallback: () {
                          answer = 2;
                          checkAnswer();
                        },
                      ),
                      Choice(
                        country: countries[selectedCountries[3]]["Code"],
                        voidCallback: () {
                          answer = 3;
                          checkAnswer();
                        },
                      ),
                    ],
                  )
                : Container(),
            playing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Choice(
                        country: countries[selectedCountries[4]]["Code"],
                        voidCallback: () {
                          answer = 4;
                          checkAnswer();
                        },
                      ),
                      Choice(
                        country: countries[selectedCountries[5]]["Code"],
                        voidCallback: () {
                          answer = 5;
                          checkAnswer();
                        },
                      ),
                    ],
                  )
                : Container(),
            playing
                ? Container()
                : Image.asset(
                    "assets/globe.png",
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
            playing
                ? Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        border: Border.all(width: 3, color: Colors.white)),
                    width: double.maxFinite,
                    child: Text(
                        countries[selectedCountries[correctCountry]]["Name"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 26, color: Colors.yellow)),
                  )
                : Container(
                    margin: EdgeInsets.all(20),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          playing = true;
                          score = 0;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        child: Text(
                          "Start",
                          style: TextStyle(fontSize: 26, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
            Container(
              decoration: BoxDecoration(color: Colors.black),
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    child: Text("Your Score : $score",
                        style: TextStyle(fontSize: 26, color: Colors.white)),
                  ),
                  //A thin horizontal line, with padding on either side.
                  Divider(
                    color: Colors.white,
                    height: 2,
                  ),
                  Container(
                    child: Text("Best Score : $bestScore",
                        style: TextStyle(fontSize: 26, color: Colors.white)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
