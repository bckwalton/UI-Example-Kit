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
      theme: ThemeData(brightness: Brightness.dark),
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
    String subText = 'Placeholder2',
    Color color = Colors.blue,
    String imageUrl =
        'https://www.hendersonparkinn.com/wp-content/uploads/2018/10/A-group-of-people-waving-their-arms-in-a-dance-club.jpg'}) {
  if (timeFromNow == null) {
    timeFromNow = Duration(days: 1);
  }
  DateTime now = DateTime.now().subtract(timeFromNow);
  String formattedDate = DateFormat('EEE').format(now);

  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    // make sure we apply clip it properly
    child: Container(
      height: 100,
      width: 200,
      child: BackdropFilter(
        filter: prefix0.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Padding(
          child: Row(children: <Widget>[
            Padding(
                child: Row(children: <Widget>[
                  Text(now.day.toString(), style: TextStyle(fontSize: 50)),
                  Padding(
                    child: Text(
                      formattedDate.toUpperCase(),
                      style: TextStyle(fontSize: 10),
                    ),
                    padding: EdgeInsets.only(top: 30, left: 5),
                  ),
                ]),
                padding: EdgeInsets.only(right: 20)),
            Container(
                width: 75,
                child: AutoSizeText(
                  subText,
                  softWrap: false,
                  style: TextStyle(fontSize: 15),
                  maxLines: 2,
                  minFontSize: 10,
                  maxFontSize: 30,
                ))
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM d yyyy').format(now);
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
                      style: TextStyle(fontSize: 32, fontFamily: 'Lexend Deca'),
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
                      child: Text(
                        'Review',
                        style: TextStyle(fontSize: 30),
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                    Row(
                      children: <Widget>[glowButtonDate()],
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
