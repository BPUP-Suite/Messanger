import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/start/Login/loginPassword.dart';

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

  final email = "test@test.com";

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


              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Per favore inserisci la tua email';
                }
                if (value != email) {
                  return 'Email errata';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPassword(),
                      ),
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
