import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/start/Login/loginPassword.dart';
import 'package:messanger_bpup/faces/start/Signup/signup.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';

class EmailCheck extends StatelessWidget {
  const EmailCheck({super.key});


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Color(0xff354966),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Email",
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
              EmailCheckForm(),
            ],
          ),
          // child: PhoneForm(),
        ),
      ),
    );
  }
}

class EmailCheckForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  late String emailValue;

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
                labelText: 'Email',

                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),

              //aggiungi roba pattern email di controllo
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Per favore inserisci la tua email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]+').hasMatch(value)) {
                  return 'Non hai inserito un indirizzo email';
                }
                emailValue = value;

                return null;
              },

            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    checkEmailAndNavigate(context, emailValue);
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

void checkEmailAndNavigate(BuildContext context, String emailValue) async {
  String emailResponse = await JsonParser.emailCheckJson(emailValue);

  if (emailResponse == "signup") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Signup(emailValue: emailValue),
      ),
    );
  }
  else{
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPassword(emailValue: emailValue),
      ),
    );
  }
}

