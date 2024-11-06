import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/Settings/changeThemes.dart';
import 'package:messanger_bpup/faces/Settings/security.dart';
import 'package:messanger_bpup/faces/Settings/storage.dart';
import 'package:messanger_bpup/faces/start/emailCheck.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
            //to Security
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Security(),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      leading: ExcludeSemantics(
                        child: Icon(
                          Icons.shield_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Security",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xff202c3e).withOpacity(0.4),
                  ),
                ],
              ),
            ),
            //to Themes
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeThemes(),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      leading: ExcludeSemantics(
                        child: Icon(
                          Icons.color_lens_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Themes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xff202c3e).withOpacity(0.4),
                  ),
                ],
              ),
            ),
            //to Storage
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Storage(),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      leading: ExcludeSemantics(
                        child: Icon(
                          Icons.folder_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Storage",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xff202c3e).withOpacity(0.4),
                  ),
                ],
              ),
            ),
            //logout
            GestureDetector(
              onTap: () {
                resetBiometricsPreference();      //works
                resetLoggedIn();                  //workava, spero continui a farlo
                resetLocalDatabase();

                backToLoginAfterLogout(context);  //works
              },
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      leading: ExcludeSemantics(
                        child: Icon(
                          Icons.logout_outlined,
                          color: Colors.red,
                        ),
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xff202c3e).withOpacity(0.4),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //1° funzione del logout: reset preferenza biometrica
  Future<void> resetBiometricsPreference() async {
    SharedPreferences biometricsPreference =
        await SharedPreferences.getInstance();
    biometricsPreference.setBool('biometricEnabled', false);
    print("Preferenza biometrica resettata a FALSE");
  }

  //2° funzione del logout: rimanda al login
  void backToLoginAfterLogout(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailCheck(),
      ),
    );
  }

  //3° funzione del logout: reset preferenza isLoggedIn
  Future<void> resetLoggedIn() async {
    SharedPreferences isLoggedInPreference =
    await SharedPreferences.getInstance();
    isLoggedInPreference.setBool('isLoggedIn', false);
    print("Preferenza isLoggedIn a FALSE");
  }

  //4° funzione del logout: fa sparire il database locale
  Future<void> resetLocalDatabase() async {
    final localDatabasePath = await getDatabasesPath();
    final localDBPath = join(localDatabasePath, 'localDatabase.db');

    await deleteDatabase(localDBPath);
    print("Database locale eliminato (speriamo)");

  }


}
