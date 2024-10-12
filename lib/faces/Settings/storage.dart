import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Storage extends StatefulWidget {
  const Storage({super.key});

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  late SharedPreferences prefs;
  late bool storagebiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    retrieveBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        title: Text(
          "Storage",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff202c3e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            //stampa della preferenza biometrica
            Text(
              "PROVA --- Preferenza biometria: " + storagebiometricEnabled.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
            ),
          ],
        ),
      ),

    );
  }

  //get della preferenza biometrica
  retrieveBiometrics() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      storagebiometricEnabled = prefs.getBool("biometricEnabled") ?? false;
    });
  }
}

