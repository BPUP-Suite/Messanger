import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/Settings/changeThemes.dart';
import 'package:messanger_bpup/faces/Settings/security.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff202c3e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text(
                "Change Themes",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeThemes(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text(
                "Security",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Security(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
