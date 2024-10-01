import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/chatList.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';



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
            SignupForm(emailValue),
          ],
        ),
        // child: PhoneForm(),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  late String emailValue;
  SignupForm(String emailValue){
    this.emailValue=emailValue;
  }

  final _formKey = GlobalKey<FormState>();


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
            // TextFormField(
            //   cursorColor: Colors.white,
            //   style: TextStyle(color: Colors.white),
            //   decoration: InputDecoration(
            //     labelText: 'Email',
            //
            //     labelStyle: TextStyle(color: Colors.white),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.white),
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.white),
            //     ),
            //   ),
            //
            //
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Per favore inserisci la tua email';
            //     }
            //     return null;
            //   },
            // ),
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
              validator: (value) {
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
                    SignupAndNavigate(context, emailValue, nameValue, surnameValue, handleValue, passwordValue, confirm_passwordValue);
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



void SignupAndNavigate(BuildContext context, String emailValue, String nameValue, String surnameValue, String handleValue, String passwordValue, String confirm_passwordValue) async {
  bool signupResponse = await JsonParser().signupJson(emailValue, nameValue, surnameValue, handleValue, passwordValue, confirm_passwordValue);

  print(signupResponse == true);

  if (signupResponse) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatList(),
      ),
    );
  }
  else{
    print("non fa una cazzuuuuuuuuzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
    print(signupResponse);
    print("non fa una cazzuuuuuuuuzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
  }
}


