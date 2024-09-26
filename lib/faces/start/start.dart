import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/start/phone.dart';
import 'package:messanger_bpup/main.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Start",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(
              "Start",
            style: TextStyle(
              fontSize: 30
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Phone(),
              ),
            );
          },
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
