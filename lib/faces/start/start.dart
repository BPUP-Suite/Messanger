import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messanger_bpup/faces/chatList.dart';
import 'package:messanger_bpup/faces/chats/chatPanel.dart';
import 'package:messanger_bpup/faces/start/emailCheck.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
          title: Text(
              "Start",
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
            BiometricsAppOpening(),
            ElevatedButton(
              child: Text(
                "Email",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailCheck(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text(
                "Chat List",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatList(),
                  ),
                );
              },
            ),
            // ElevatedButton(
            //   child: Text(
            //     "Password Login",
            //     style: TextStyle(
            //         fontSize: 30
            //     ),
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => LoginPassword(),
            //       ),
            //     );
            //   },
            // ),
            ElevatedButton(
              child: Text(
                "Chat",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPanel(chatID: null,),
                  ),
                );
              },
            ),
            // ElevatedButton(
            //   child: Text(
            //     "Signup",
            //     style: TextStyle(
            //         fontSize: 30
            //     ),
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Signup(),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),

    );
  }
}



//Biometrics
class BiometricsAppOpening extends StatefulWidget {
  const BiometricsAppOpening({super.key});

  @override
  State<BiometricsAppOpening> createState() => _BiometricsAppOpeningState();
}

class _BiometricsAppOpeningState extends State<BiometricsAppOpening> {
  bool _isBiometricEnabled = false;
  late LocalAuthentication auth;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    _loadBiometricPreference().then((_) {
      _authenticate();
    });

  }



  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }



  // Carica lo stato della preferenza dalle SharedPreferences
  //subito non andava, poi ho fatto /flutter clean e /flutter pub get e magicamente salva la preferenza
  Future<void> _loadBiometricPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBiometricEnabled = prefs.getBool('biometricEnabled') ?? false;
      print("preferenza biometrica su start: $_isBiometricEnabled");
    });
  }



  Future<void> _authenticate() async {
    if(_isBiometricEnabled == true){
      print("biometrics enabled");
      try{
        bool authenticated = await auth.authenticate(
          //messaggino che appare sopra al sensore quando appare il pannello dell'impronta
          localizedReason: "Autenticazione",
          options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: true     //solo biometria --> no password, codici, pin...
          ),
        );

        //stampa true o false se l'autenticazione è avvenuta
        print("Authenticated: $authenticated");

        // if(authenticated){
        //
        // }

      }on PlatformException catch (e) {
        print(e);
      }
    }
    else{
      print("biometrics not enabled");
    }
  }


  // Future<void> _getAvailableBiometrics() async {
  //   List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
  //
  //   print("Lista dispositivi biometrici: $availableBiometrics");
  //
  //   if(!mounted) {
  //     return;
  //   }
  // }
}












