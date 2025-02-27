import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_and_doctor_appointment/cardModel.dart';
import 'package:health_and_doctor_appointment/doctorProfile.dart';
import 'package:health_and_doctor_appointment/exploreList.dart';
import 'package:health_and_doctor_appointment/firebaseAuth.dart';
import 'package:health_and_doctor_appointment/myAppointments.dart';
import 'package:health_and_doctor_appointment/nearbyModel.dart';
import 'package:health_and_doctor_appointment/userProfile.dart';
import 'package:health_and_doctor_appointment/doctorsList.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({Key key, this.user}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();

  // void out(BuildContext context) {
  //   Navigator.pop(context);
  //   FirebaseAuthDemo().out2(context);
  // }
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  var _bottomNavIndex = 0;
  //List<Color> _colors;

  @override
  Widget build(BuildContext context) {
    String _message;
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    setState(() {
      if (hour >= 5 && hour < 12) {
        _message = 'Good Morning';
      } else if (hour >= 12 && hour <= 17) {
        _message = 'Good Afternoon';
      } else if ((hour > 17 && hour <= 23) || (hour >= 0 && hour < 5)) {
        _message = 'Good Evening';
      }
    });

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.7],
          colors: [
            Colors.lightBlue[50],
            Colors.lightBlue[100],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.lightBlue[50],
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: IconButton(
              icon: Icon(
                TablerIcons.align_left,
                size: 30,
                color: Colors.grey[800],
              ),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey[800],
            size: 50,
          ),
          //title: Text("Main Page"),
          actions: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 10),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      print("Button tapped");
                    },
                    child: Icon(
                      Icons.notifications_active,
                      size: 28,
                    ),
                  ),
                  RawMaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );
                    },
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            //physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 10,
                        top: 5,
                        left: 5,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Welcome,",
                        style: GoogleFonts.lato(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Medico',
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            'v.1.0.0',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      child: Icon(TablerIcons.home),
                    ),
                    Text("Home"),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MainPage(
                      user: widget.user,
                    );
                  }));
                },
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      child: Icon(TablerIcons.virus),
                    ),
                    Text("Covid-19"),
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      child: Icon(Icons.sick_outlined),
                    ),
                    Text("Diseases"),
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      child: Icon(Icons.feedback_outlined),
                    ),
                    Text("Feedback"),
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      child: Icon(Icons.help_outline),
                    ),
                    Text("Help"),
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      child: Icon(Icons.logout),
                    ),
                    Text("Logout"),
                  ],
                ),
                onTap: () {
                  _signOut().whenComplete(() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FireBaseAuth()));
                  });
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          //left: 20,
                          top: 8,
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              width: double.infinity,
                              child: Text(
                                _message,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[700]),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              width: double.infinity,
                              child: Text(
                                widget.user.displayName,
                                style: GoogleFonts.lato(fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Explore",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        height: 150,
                        padding: EdgeInsets.only(top: 14),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            //print("images path: ${cards[index].cardImage.toString()}");
                            return Container(
                              margin: EdgeInsets.only(right: 14),
                              height: 150,
                              width: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(cards[index].cardBackground),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[400],
                                      blurRadius: 4.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(3, 3),
                                    ),
                                  ]
                                  // image: DecorationImage(
                                  //   image: AssetImage(cards[index].cardImage),
                                  //   fit: BoxFit.fill,
                                  // ),
                                  ),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ExploreList(
                                              type: cards[index].doctor,
                                            )),
                                  );
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 29,
                                          child: Icon(
                                            cards[index].cardIcon,
                                            size: 26,
                                            color: Color(
                                                cards[index].cardBackground),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        cards[index].doctor,
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nearby doctors",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('doctors')
                            .orderBy('city')
                            .startAt(['Rajkot']).endAt(
                                ['Rajkot' + '\uf8ff']).snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data.docs.map(
                              (document) {
                                return Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 0),
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorProfile(
                                                    doctor: document['name'],
                                                  )),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: 25,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                document['name'],
                                                style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Text(
                                                document['type'],
                                                style: GoogleFonts.lato(
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          );
                        },
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  width: 230,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        tooltip: 'Messages',
                        iconSize: 28,
                        icon: Icon(FlutterIcons.chat_mco),
                        onPressed: () {},
                      ),
                      IconButton(
                        tooltip: 'Find',
                        iconSize: 25,
                        icon: Icon(FlutterIcons.search_faw),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorsList()),
                          );
                        },
                      ),
                      IconButton(
                        tooltip: 'New Appointment',
                        iconSize: 30,
                        icon: Icon(FlutterIcons.add_circle_mdi),
                        onPressed: () {},
                      ),
                      IconButton(
                        tooltip: 'My Appointments',
                        iconSize: 28,
                        icon: Icon(FlutterIcons.calendar_clock_mco),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAppointments(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}
