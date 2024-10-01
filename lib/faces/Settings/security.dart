import 'package:flutter/material.dart';

class Security extends StatelessWidget {
  const Security({super.key});

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
            ElevatedButton(
              onPressed: () {

              },
              child: Text("ciao"),
            )
          ],
        ),
      ),

    );
  }
}
