import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/Settings/profile.dart';
import 'package:messanger_bpup/faces/Settings/settings.dart';
import 'package:messanger_bpup/faces/start/start.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var chatNumber = 14;
    // var i = 0;
    return Scaffold(
      backgroundColor: Color(0xff354966),
      extendBodyBehindAppBar: true,                     //importante per potenziali effetti blur nell'appbar
      appBar: AppBar(
        title: Text(
          "Chat List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff202c3e),
        scrolledUnderElevation: 0,
        //Non fa cambiare colore alla AppBar quando la scrollbar ci va sotto
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),

      ),
      body: Scrollbar(
        child: ListView(
          children: [
            Container(
              child: ListTile(
                leading: ExcludeSemantics(
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    child: Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(
                  "Saved",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  "Sottotitolo",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Color(0xff202c3e).withOpacity(0.4),
            ),
            for (int i = 0; i < chatNumber; i++)
              Column(
                children: [
                  Container(
                    // Adjust padding
                    child: ListTile(
                      leading: ExcludeSemantics(
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://picsum.photos/200'),
                        ),
                      ),
                      title: Text(
                        "Item $i",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        "Sottotitolo",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xff202c3e).withOpacity(0.4),
                  ),
                ],
              )
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xff202c3e),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80, bottom: 15),
              child: CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage('https://picsum.photos/200'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Text(
                "Nome Cognome",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              child: ElevatedButton(
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Start (da togliere)"),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Start(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //action button
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.lightBlue,

        animatedIcon: AnimatedIcons.menu_close,

        animatedIconTheme: IconThemeData(color: Colors.white),
        spacing: 5,
        spaceBetweenChildren: 5,
        closeManually: false,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,

        // 3 pulsantini che appaiono quando si clicca il pulsante
        children: [
          SpeedDialChild(
              child: Icon(Icons.add), shape: CircleBorder(), label: "testo"),
          SpeedDialChild(
            child: Icon(Icons.add),
            shape: CircleBorder(),
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            shape: CircleBorder(),
          ),
        ],
      ),
    );
  }
}
