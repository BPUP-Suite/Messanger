import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/start/Login/loginPassword.dart';
import 'package:messanger_bpup/faces/start/Signup/signup.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';

class EmailCheck extends StatelessWidget {
  const EmailCheck({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
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
    );
  }
}

class EmailCheckForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  late final String emailValue;

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
                emailValue = value;
                return null;
              },

            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // print("vafaffacualoooooooooooo");
                    // print(JsonParser().emailCheckJson(emailValue));
                    // if(JsonParser().emailCheckJson(emailValue) == "signup") {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Signup(),
                    //     ),
                    //   );
                    // }
                    // else{
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => LoginPassword(),
                    //     ),
                    //   );
                    // }
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

