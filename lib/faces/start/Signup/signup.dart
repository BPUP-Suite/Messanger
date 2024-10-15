import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/chatList.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';
import 'dart:async';

bool handleAvailabilityValidator = false;       //controllo nel validator

class Signup extends StatelessWidget {
  const Signup({super.key, required this.emailValue});

  final emailValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        title: Text(
          "Signup",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff202c3e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        alignment: Alignment.center, // Center content horizontally
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SignupForm(emailValue: emailValue),
          ],
        ),
        // child: PhoneForm(),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  final String emailValue;

  SignupForm({required this.emailValue});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  Timer? _handleAvailabilityTimer;

  late String passwordValue;
  late String confirm_passwordValue;
  late String nameValue;
  late String surnameValue;
  late String handleValue;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 250,
        child: Column(
          children: <Widget>[
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Per favore inserisci la tua password';
                }
                passwordValue = value;
                return null;
              },
            ),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Conferma Password',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Per favore ripeti la tua password';
                }
                confirm_passwordValue = value;
                return null;
              },
            ),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Per favore inserisci il tuo nome';
                }
                nameValue = value;
                return null;
              },
            ),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Cognome',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Per favore inserisci il tuo cognome';
                }
                surnameValue = value;
                return null;
              },
            ),
            TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Handle',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),

              //Quando il testo non viene modificato per 3 secondi fa una chiamata API
              //per capire se l'handle è già in uso oppure no.
              onChanged: (text) {
                if (_handleAvailabilityTimer?.isActive ?? false)
                  _handleAvailabilityTimer!.cancel();
                _handleAvailabilityTimer =
                    Timer(const Duration(milliseconds: 3000), () {
                      checkHandleAvailability(text);
                });
              },
              validator: (value) {
                  if(!handleAvailabilityValidator) {
                    print(handleAvailabilityValidator);
                    return 'Handle già in uso';
                  }
                  if (value == null || value.isEmpty) {
                    return 'Per favore inserisci il tuo handle';
                  }
                  handleValue = value;
                  return null;
                },

                ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SignupAndNavigate(
                      context,
                      widget.emailValue,
                      // Usiamo widget.emailValue poiché è definito nel StatefulWidget
                      nameValue,
                      surnameValue,
                      handleValue,
                      passwordValue,
                      confirm_passwordValue,
                    );
                  }
                },
                child: Text('Invia'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SignupForm extends StatelessWidget {
//   late String emailValue;
//   SignupForm(String emailValue){
//     this.emailValue=emailValue;
//   }
//
//   final _formKey = GlobalKey<FormState>();
//
//
//   late String passwordValue;
//   late String confirm_passwordValue;
//   late String nameValue;
//   late String surnameValue;
//   late String handleValue;
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Container(
//         width: 250,
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               cursorColor: Colors.white,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 labelText: 'Password',
//
//                 labelStyle: TextStyle(color: Colors.white),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Per favore inserisci la tua password';
//                 }
//                 passwordValue = value;
//                 return null;
//               },
//             ),
//             TextFormField(
//               cursorColor: Colors.white,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 labelText: 'Conferma Password',
//
//                 labelStyle: TextStyle(color: Colors.white),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Per favore ripeti la tua password';
//                 }
//                 confirm_passwordValue = value;
//                 return null;
//               },
//             ),
//             TextFormField(
//               cursorColor: Colors.white,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 labelText: 'Nome',
//
//                 labelStyle: TextStyle(color: Colors.white),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Per favore inserisci il tuo nome';
//                 }
//                 nameValue = value;
//                 return null;
//               },
//             ),
//             TextFormField(
//               cursorColor: Colors.white,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 labelText: 'Cognome',
//
//                 labelStyle: TextStyle(color: Colors.white),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Per favore inserisci il tuo cognome';
//                 }
//                 surnameValue = value;
//                 return null;
//               },
//             ),
//             TextFormField(
//               cursorColor: Colors.white,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 labelText: 'Handle',
//
//                 labelStyle: TextStyle(color: Colors.white),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Per favore inserisci il tuo handle';
//                 }
//                 handleValue = value;
//                 return null;
//               },
//               onChanged: (text) {
//                 print("-------------------------------------------------testo cambiato in: $text");
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     SignupAndNavigate(context, emailValue, nameValue, surnameValue, handleValue, passwordValue, confirm_passwordValue);
//                   }
//                 },
//                 child: Text('Invia'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

void SignupAndNavigate(
    BuildContext context,
    String emailValue,
    String nameValue,
    String surnameValue,
    String handleValue,
    String passwordValue,
    String confirm_passwordValue) async {
  bool signupResponse = await JsonParser().signupJson(emailValue, nameValue,
      surnameValue, handleValue, passwordValue, confirm_passwordValue);

  print(signupResponse == true);

  if (signupResponse) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatList(),
      ),
    );
  } else {
    print(signupResponse);
  }
}



void checkHandleAvailability(String handle) async {
  bool handleAvailability = await JsonParser().handleAvailability(handle);

  // print(handleAvailability == true);

  if (handleAvailability) {
    print(handleAvailability);
    handleAvailabilityValidator = true;
  }else {
    print(handleAvailability);
    handleAvailabilityValidator = false;
  }
}
