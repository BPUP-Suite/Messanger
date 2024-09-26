import 'package:flutter/material.dart';

class Phone extends StatelessWidget {
  const Phone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Phone",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Center(
        child: Column(
          children: [
            PhoneCard()
          ],
        ),
        // child: PhoneForm(),
      ),
    );
  }
}






class PhoneCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(

                decoration: InputDecoration(labelText: 'Telefono'),
              ),
              SizedBox(height: 10),
              // TextField(
              //   decoration: InputDecoration(labelText: 'Password'),
              //   obscureText: true,
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle login logic here
                },
                child: Text('Invia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class SignupCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         margin: EdgeInsets.all(20.0),
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 decoration: InputDecoration(labelText: 'Full Name'),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle signup logic here
//                 },
//                 child: Text('Signup'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }