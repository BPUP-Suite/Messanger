import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        backgroundColor: Color(0xff202c3e),
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/200'), // Sostituisci con il percorso della tua immagine
            ),
            SizedBox(width: 15), // Spazio tra l'avatar e il testo
            Text(
              "Nome Chat",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Icon(Icons.more_vert_rounded),
          ],
        ),
      ),

      body: Stack(
        children: [
          MsgBottomBar(),
        ]
      )
    );
  }
}



class MsgBottomBar extends StatelessWidget {
  const MsgBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //   height: 40,
          //   child: SpeedDial(
          //     backgroundColor: Colors.lightBlue,
          //     animatedIcon: AnimatedIcons.menu_close,
          //     icon: Icons.add,
          //     animatedIconTheme: IconThemeData(color: Colors.white),
          //     spacing: 5,
          //     spaceBetweenChildren: 5,
          //     closeManually: false,
          //     children: [
          //       SpeedDialChild(
          //           child: Icon(Icons.add),
          //           shape: CircleBorder(),
          //           label: "testo"
          //       ),
          //       SpeedDialChild(
          //         child: Icon(Icons.add),
          //         shape: CircleBorder(),
          //       ),
          //       SpeedDialChild(
          //         child: Icon(Icons.add),
          //         shape: CircleBorder(),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 400,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              
                            },
                            child: Text("ciao"),
                          ),
                        ),
                      );
                    }
                    );
              },
              child: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Icon(Icons.attach_file, color: Colors.white),
              ),
            ),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(left: 15),

              width: 250,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.blue,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(100)
              ),
              child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Messaggio",
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7)
                      )
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Icon(Icons.send, color: Colors.white, size: 27,),
          ),
        ],
      ),
    );
  }
}



