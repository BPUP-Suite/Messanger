import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messanger_bpup/faces/chatList.dart';
import 'package:messanger_bpup/faces/start/emailCheck.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool _isLoggedIn = false;




//DA OTTIMIZZARE CORRETTAMENTE MA COME È ORA FUNZIONA
//SE UTENTE LOGGATO ALLORA MANDA A CHATLIST, ALTRIMENTI NON DOVREBBE FARE UNA SEGA
Future<bool> isLoggedInSkip(context) async{

  await _loadLoggedIn();
  print("Start skip Loggato?: $_isLoggedIn");
  if(_isLoggedIn){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatList(),
      ),
    );
  }
  if(!_isLoggedIn){
    return false;
  }
  return false;
}




class Start extends StatelessWidget {
  const Start({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        // title: Text(
        //   "Start",
        //   style: TextStyle(color: Colors.white),
        // ),
        centerTitle: true,
        backgroundColor: Color(0xff354966),
        // iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BiometricsAppOpening(),
              Container(
                margin: EdgeInsets.all(30),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  "Inizia",
                  style: TextStyle(fontSize: 20, color: Colors.white),
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
            ],
          ),
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
    auth = LocalAuthentication();

    _loadBiometricPreference().then((_) {
      _authenticate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
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
    if (_isBiometricEnabled == true) {
      print("biometrics enabled");
      try {
        bool authenticated = await auth.authenticate(
          //messaggino che appare sopra al sensore quando appare il pannello dell'impronta
          localizedReason: "Autenticazione",
          options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly:
                  true //solo biometria --> no password, codici, pin...
              ),
        );

        //stampa true o false se l'autenticazione è avvenuta
        print("Authenticated: $authenticated");

        if(authenticated){
          isLoggedInSkip(context);              //NON GLI PIACE MA FUNZIONA (?)
        }
      } on PlatformException catch (e) {
        print(e);
      }
    } else {
      print("biometrics not enabled");
      isLoggedInSkip(context);              //NON GLI PIACE MA FUNZIONA (?)
    }
  }
}

//carica preferenza se utente loggato oppure no
Future<void> _loadLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  print("Logged? start load: $_isLoggedIn");
}
