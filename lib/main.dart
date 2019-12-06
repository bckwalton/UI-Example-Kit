import 'dart:math';
import 'dart:ui' as prefix0;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Based wholly on: https://dribbble.com/shots/3884284-Entertainment-Magazine by Chris Yang.
// Didn't do

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

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

Widget libraryView(context,
    {double height = 500,
    double width = 500,
    String leadText = 'Libraries',
    String subText = 'see all',
    Color subTextColor,
    Color leadTextColor,
    List<String> albumCoverUrls = const []}) {
  if (subTextColor == null) {
    subTextColor = Theme.of(context).primaryTextTheme.subtitle.color;
  }
  if (leadTextColor == null) {
    leadTextColor = Theme.of(context).primaryTextTheme.title.color;
  }
  return Container(
      //height: height,
      width: width,
      child: Column(children: <Widget>[
        ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            Stack(children: <Widget>[
              Align(
                child: Text(
                  leadText,
                  style: TextStyle(fontSize: 20),
                ),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child: Text(
                  subText,
                  style: TextStyle(fontSize: 18),
                ),
                alignment: Alignment.centerRight,
              ),
            ]),
            Container(
              width: width,
              child: (albumCoverUrls.isNotEmpty)
                  ? ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: albumCoverUrls.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                // make sure we apply clip it properly
                                child: Container(
                                    height: height - 50,
                                    width: width - 50,
                                    child: Image(
                                      image:
                                          NetworkImage(albumCoverUrls[index]),
                                      fit: BoxFit.cover,
                                    ))));
                      })
                  : Container(),
            )
          ],
        ),
      ]));
}

Widget glowButtonDate(
    {double height = 100,
    double width = 200,
    Duration timeFromNow,
    String text = 'POPULAR',
    Color color = Colors.blue,
    double padRight = 8.0,
    BlendMode blendMode = BlendMode.darken,
    String imageUrl =
        'https://www.hendersonparkinn.com/wp-content/uploads/2018/10/A-group-of-people-waving-their-arms-in-a-dance-club.jpg'}) {
  if (timeFromNow == null) {
    timeFromNow = Duration(days: 1);
  }
  DateTime then = DateTime.now().subtract(timeFromNow);
  String textDay = DateFormat('EE').format(then);
  String textMonth = DateFormat(DateFormat.ABBR_MONTH).format(then);
  String year = DateFormat(DateFormat.YEAR).format(then);

  return Padding(
    padding: EdgeInsets.only(right: padRight),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      // make sure we apply clip it properly
      child: Container(
        height: height,
        width: width,
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
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
            colorFilter: ColorFilter.mode(color, blendMode),
          ),
        ),
      ),
    ),
  );
}

Widget trendingCards(context,
    {double height = 500,
    double width = 300,
    String leadText = 'Trending',
    Color leadTextColor = Colors.orangeAccent,
    Color midTextColor,
    Color bottomTextColor,
    String midText = 'Music magazine',
    String bottomText = 'Provide the latest music information',
    String imageUrl =
        'https://images.rapgenius.com/dc547861a593b54a64ea80a468661ade.1000x1000x1.png',
    Color dateCardColor = Colors.tealAccent,
    bool showDateCard = true,
    Duration timeFromNow}) {
  if (midTextColor == null) {
    midTextColor = Theme.of(context).primaryTextTheme.title.color;
  }
  if (bottomTextColor == null) {
    bottomTextColor = Theme.of(context).primaryTextTheme.subtitle.color;
  }
  if (timeFromNow == null) {
    timeFromNow = Duration(days: 1);
  }
  String formattedDate =
      DateFormat('MMM d yyyy').format(DateTime.now().subtract(timeFromNow));
  return Container(
    height: height,
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: AutoSizeText(
            leadText.toUpperCase(),
            maxLines: 1,
            minFontSize: 10,
            maxFontSize: 40,
            style: TextStyle(fontSize: 14, color: leadTextColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: AutoSizeText(
            midText,
            softWrap: false,
            maxLines: 1,
            minFontSize: 20,
            maxFontSize: 40,
            style: TextStyle(fontSize: 30, color: midTextColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: AutoSizeText(
            bottomText,
            maxLines: 1,
            minFontSize: 5,
            maxFontSize: 40,
            style: TextStyle(fontSize: 11, color: bottomTextColor),
          ),
        ),
        Stack(children: <Widget>[
          Container(
            height: width,
          ),
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // make sure we apply clip it properly
              child: Container(
                  height: width - 20,
                  width: width - 20,
                  child: Image(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ))),
          Positioned(
              bottom: 10,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // make sure we apply clip it properly
                  child: (showDateCard)
                      ? Container(
                          decoration: BoxDecoration(
                              color: dateCardColor,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF000000).withAlpha(60),
                                  blurRadius: 6.0,
                                  spreadRadius: 10.0,
                                  offset: Offset(
                                    2.0,
                                    10.0,
                                  ),
                                ),
                              ]),
                          //color: dateCardColor,
                          //height: 50,
                          //width: width / 4,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: AutoSizeText(
                              formattedDate,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ),
                        )
                      : Container()))
        ])
      ],
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
      //height: MediaQuery.of(context).size.height,
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
                height: AppBar().preferredSize.height + 20,
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(children: <Widget>[
                      AutoSizeText(
                        'Today, ' + formattedDate,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        minFontSize: 10,
                        maxFontSize: 20,
                        style: TextStyle(fontSize: 15),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(children: <Widget>[
                      AutoSizeText(
                        'Neon Night',
                        textAlign: TextAlign.justify,
                        maxLines: 1,
                        style: TextStyle(fontSize: 32),
                        minFontSize: 10,
                        maxFontSize: 40,
                      )
                    ]),
                  )
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
                                    blendMode: BlendMode.difference,
                                    imageUrl:
                                        'https://i.pinimg.com/originals/e8/bb/10/e8bb108d1aab76692f6db2af816b8dec.jpg',
                                    timeFromNow: Duration(
                                      days: numGen.nextInt(1000),
                                    )),
                                glowButtonDate(
                                    color: Colors.tealAccent,
                                    imageUrl:
                                        'https://blog.spoongraphics.co.uk/wp-content/uploads/2017/01/thumbnail-2.jpg',
                                    blendMode: BlendMode.colorDodge,
                                    timeFromNow: Duration(
                                      seconds: numGen.nextInt(10000),
                                    )),
                                glowButtonDate(
                                    text: 'Hated',
                                    imageUrl:
                                        'https://cdn8.openculture.com/2018/02/26214611/Arlo-safe-e1519715317729.jpg',
                                    blendMode: BlendMode.colorBurn,
                                    color: Colors.redAccent,
                                    timeFromNow: Duration(
                                      hours: numGen.nextInt(1000),
                                    )),
                                glowButtonDate(
                                    text: 'Loved',
                                    imageUrl:
                                        'https://media.vanityfair.com/photos/561d1b04319af15240f9b03f/master/pass/t-rihanna-cover-art-roy-nachum.jpg',
                                    blendMode: BlendMode.dst,
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
                    Container(
                        width: width,
                        height: height / 2.32,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              trendingCards(context,
                                  bottomText:
                                      'Do you know the meaning behind your favorite historic Album Covers?',
                                  imageUrl:
                                      'https://images.genius.com/66715046cd34d7cb81fe0f31399407c5.1000x1000x1.jpg'),
                              trendingCards(context,
                                  midText: 'Entertaiment Weekly',
                                  leadTextColor: Colors.tealAccent,
                                  showDateCard: false,
                                  imageUrl:
                                      'https://www.thisdayinmusic.com/wp-content/uploads/2018/05/the-dark-side-of-the-moon.jpg'),
                              trendingCards(context,
                                  midText: 'Port of Song',
                                  leadTextColor: Colors.yellow,
                                  timeFromNow:
                                      Duration(days: numGen.nextInt(1000)),
                                  imageUrl:
                                      'https://www.billboard.com/files/styles/900_wide/public/media/Green-Day-American-Idiot-album-covers-billboard-1000x1000.jpg'),
                              trendingCards(context,
                                  midText: 'The Rumble',
                                  leadTextColor: Colors.purple,
                                  imageUrl:
                                      'https://www.billboard.com/files/styles/900_wide/public/media/The-Beatles-Abbey-Road-album-covers-billboard-1000x1000.jpg')
                            ])),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    libraryView(context, albumCoverUrls: [
                      'https://i.pinimg.com/originals/45/44/5d/45445dc8dae93620a28525b5bf373150.jpg',
                      'https://www.thedailyclutch.com/wp-content/uploads/2019/02/91kny7EUh5L._SL1425_-2-e1550263623691-750x500.jpg',
                      'https://images.fastcompany.net/image/upload/w_1280,f_auto,q_auto,fl_lossy/wp-cms/uploads/2019/07/p-1-90375683an-astrophysicist-explains-the-most-famous-album-art-of-the-century.jpg'
                    ])
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
