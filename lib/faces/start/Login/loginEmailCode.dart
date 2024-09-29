import 'package:flutter/material.dart';

class LoginEmailCode extends StatelessWidget {
  const LoginEmailCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        title: Text(
          "Email Code",
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
            EmailLoginCode(),
            ElevatedButton(
              onPressed: () {

              },
              child: Text("Invio"),
            )
          ],
        ),
        // child: PhoneForm(),
      ),
    );
  }
}

class EmailLoginCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: TextField(
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
        ),
        // obscureText: true,
        decoration: InputDecoration(
          labelText: 'Mail Code',

          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
