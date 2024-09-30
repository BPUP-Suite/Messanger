import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/chatList.dart';
import 'package:messanger_bpup/faces/chats/chat.dart';
import 'package:messanger_bpup/faces/start/Login/loginEmailCode.dart';
import 'package:messanger_bpup/faces/start/Login/loginPassword.dart';
import 'package:messanger_bpup/faces/start/Signup/signup.dart';
import 'package:messanger_bpup/faces/start/emailCheck.dart';
import 'package:messanger_bpup/src/obj/themes/themes.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
          title: Text(
              "Start",
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
              child: Text(
                "Email",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailCheck(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text(
                "Chat List",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatList(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text(
                "Email code",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginEmailCode(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text(
                "Password Login",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPassword(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text(
                "Chat",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Chat(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text(
                "Signup",
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Signup(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class Start extends StatelessWidget {
//   const Start({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.blue,
//         body: Center(
//           child: Builder(
//             builder: (BuildContext context) {
//               // Usa un nuovo contesto locale
//               return ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             const login()), // Usa il nuovo contesto
//                   );
//                 },
//                 // child: Container(
//                 //   height: 100,
//                 //   width: 300,
//                 //   decoration: BoxDecoration(
//                 //     color: Colors.amberAccent,
//                 //     borderRadius: BorderRadius.circular(20),
//                 //   ),
//                 //   padding: const EdgeInsets.all(30),
//                 child: const Text(
//                   "Start",
//                   style: TextStyle(
//                     fontSize: 28,
//                   ),
//                 ),
//                 // ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
