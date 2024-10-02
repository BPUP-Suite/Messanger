import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Security extends StatelessWidget {
  const Security({super.key, });

  // bool _isBiometricEnabled = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        title: Text(
          "Security",
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
            // SwitchListTile(
            //   title: Text('Abilita Autenticazione Biometrica'),
            //   value: _isBiometricEnabled,
            //   onChanged: (bool value) {
            //       _isBiometricEnabled = value;
            //   },
            // )
            BiometricsSwitchCheck(),
          ],
        ),
      ),

    );
  }
}


//Biometria

//Questa prima classe capisce se il dispositivo supporta la biometria
class BiometricsSwitchCheck extends StatefulWidget {
  const BiometricsSwitchCheck({super.key});

  @override
  State<BiometricsSwitchCheck> createState() => _BiometricsSwitchCheckState();
}

class _BiometricsSwitchCheckState extends State<BiometricsSwitchCheck> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
        (bool isSupported) => setState(() {
          _supportState = isSupported;
        }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          if (_supportState)
            BiometricsSwitch()
          else
            Text("Il dispositivo non supporta la biometria", style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}




//Questa classe invece fa apparire lo switch se il dispositivo supporta la biometria
class BiometricsSwitch extends StatefulWidget {
  @override
  _BiometricsSwitchButtonState createState() => _BiometricsSwitchButtonState();
}

class _BiometricsSwitchButtonState extends State<BiometricsSwitch> {
  bool _isBiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricPreference();
  }

  // Carica lo stato della preferenza dalle SharedPreferences
  //subito non andava, poi ho fatto /flutter clean e /flutter pub get e magicamente salva la preferenza
  Future<void> _loadBiometricPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBiometricEnabled = prefs.getBool('biometricEnabled') ?? false;
      print("ciaooooooooooo");
      print(_isBiometricEnabled);
    });
  }

  // Salva lo stato della preferenza nelle SharedPreferences
  Future<void> _saveBiometricPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometricEnabled', value);
    print("ciaooooooooooo");
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:SwitchListTile(
            title: Text(
                'Abilita Autenticazione Biometrica',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            value: _isBiometricEnabled,
            onChanged: (bool value) {
              setState(() {
                _isBiometricEnabled = value;    //ho provato e restituisce true o false nella variabile, quindi oks
                _saveBiometricPreference(value);
              });
            },
          ),
    );
  }
}
