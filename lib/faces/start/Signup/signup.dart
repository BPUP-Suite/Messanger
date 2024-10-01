import 'package:flutter/material.dart';



class Signup extends StatelessWidget {
  const Signup({super.key});

  // final signupEmail =

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
            SignupForm(),
          ],
        ),
        // child: PhoneForm(),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form valido!')),
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


