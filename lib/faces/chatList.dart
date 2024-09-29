import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/Settings/profile.dart';
import 'package:messanger_bpup/faces/Settings/settings.dart';
import 'package:messanger_bpup/faces/start/start.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        title: Text(
          "Chat List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff202c3e),
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(),
      drawer: Drawer(
        backgroundColor: Color(0xff202c3e),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80, bottom: 15),
              child: CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    'https://picsum.photos/200'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Text(
                "Nome Cognome",
                style: TextStyle(
                  color: Colors.white,
                ),
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
    );
  }
}
