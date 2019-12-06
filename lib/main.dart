import 'dart:math';
import 'dart:ui' as prefix0;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Lexend Deca'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Widget glowButtonDate(
    {double height = 100,
    double width = 200,
    Duration timeFromNow,
    String text = 'POPULAR',
    Color color = Colors.blue,
    String imageUrl =
        'https://www.hendersonparkinn.com/wp-content/uploads/2018/10/A-group-of-people-waving-their-arms-in-a-dance-club.jpg'}) {
  if (timeFromNow == null) {
    timeFromNow = Duration(days: 1);
  }
  DateTime then = DateTime.now().subtract(timeFromNow);
  String textDay = DateFormat('EE').format(then);
  String textMonth = DateFormat(DateFormat.ABBR_MONTH).format(then);
  String year = DateFormat(DateFormat.YEAR).format(then);

  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    // make sure we apply clip it properly
    child: Container(
      height: 90,
      width: 200,
      child: BackdropFilter(
        filter: prefix0.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Padding(
          child: Row(children: <Widget>[
            Padding(
                child: Row(children: <Widget>[
                  Container(
                      width: 35,
                      child: AutoSizeText(
                        then.day.toString(),
                        style: TextStyle(fontSize: 50),
                        maxLines: 1,
                        minFontSize: 30,
                        maxFontSize: 60,
                      )),
                  Padding(
                    child: AutoSizeText(
                      textDay.toUpperCase(),
                      style: TextStyle(fontSize: 10),
                      maxFontSize: 20,
                      minFontSize: 5,
                    ),
                    padding: EdgeInsets.only(top: 20, left: 5),
                  ),
                ]),
                padding: EdgeInsets.only(right: 20)),
            Container(
                width: 75,
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 3),
                    child: AutoSizeText(
                      text.toUpperCase(),
                      softWrap: false,
                      style: TextStyle(fontSize: 15),
                      maxLines: 1,
                      minFontSize: 1,
                      maxFontSize: 30,
                    ),
                  ),
                  AutoSizeText(
                    textMonth + ' ' + year,
                    softWrap: false,
                    style: TextStyle(fontSize: 15),
                    maxLines: 1,
                    minFontSize: 1,
                    maxFontSize: 30,
                  ),
                ]))
          ]),
          padding: EdgeInsets.all(20),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(color, BlendMode.darken),
        ),
      ),
    ),
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM d yyyy').format(now);
    Random numGen = Random();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        // make sure we apply clip it properly
        child: BackdropFilter(
          filter: prefix0.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Scaffold(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
              centerTitle: false,
              title: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: AppBar().preferredSize.height,
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    AutoSizeText(
                      'Today, ' + formattedDate,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(fontSize: 15),
                    ),
                  ]),
                  Row(children: <Widget>[
                    AutoSizeText(
                      'Neon Night',
                      textAlign: TextAlign.justify,
                      maxLines: 1,
                      style: TextStyle(fontSize: 32),
                      minFontSize: 10,
                      maxFontSize: 40,
                    )
                  ])
                ]),
              ),
            ),
            body: Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Review',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Container(
                            width: width,
                            height: height / 9,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                glowButtonDate(
                                    color: Colors.purpleAccent,
                                    timeFromNow: Duration(
                                      days: numGen.nextInt(1000),
                                    )),
                                glowButtonDate(
                                    color: Colors.tealAccent,
                                    timeFromNow: Duration(
                                      seconds: numGen.nextInt(10000),
                                    )),
                                glowButtonDate(
                                    text: 'Hated',
                                    color: Colors.redAccent,
                                    timeFromNow: Duration(
                                      hours: numGen.nextInt(1000),
                                    )),
                                glowButtonDate(
                                    text: 'Loved',
                                    color: Colors.pinkAccent,
                                    timeFromNow: Duration(
                                      minutes: numGen.nextInt(1000),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://www.hendersonparkinn.com/wp-content/uploads/2018/10/A-group-of-people-waving-their-arms-in-a-dance-club.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.blueGrey, BlendMode.darken),
        ),
      ),
    );
  }
}
