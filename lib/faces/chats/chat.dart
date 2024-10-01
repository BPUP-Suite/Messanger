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
          //barra superiore
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://picsum.photos/200'), // Sostituisci con il percorso della tua immagine
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
        //body
        body: Stack(children: [
          MsgBottomBar(), //barra sotto che comprende graffetta, messaggio, send button
        ]));
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
          Container(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Color(0xff202c3e),
                  context: context,
                  builder: (BuildContext context) {
                    PageController _pageController = PageController();
                    return Container(
                      height: 500,
                      child: Column(
                        children: [
                          //barretta sopra al pannellino
                          Container(
                            margin: EdgeInsets.all(20),
                            height: 4,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          Expanded(
                            child: PageView(
                              controller: _pageController,
                              children: [
                                Center(child: Text('Pannello 1')),
                                Center(child: Text('Pannello 2')),
                                Center(child: Text('Pannello 3')),
                                Center(child: Text('Pannello 4')),
                              ],
                            ),
                          ),
                          Divider(
                            height: 0.7,
                            color: Color(0xff18212f),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _pageController.jumpToPage(0);
                                  },
                                  child: MsgBottomBarAttachButton(
                                    textColor: Colors.white,
                                    backgroundColor: Colors.lightBlue,
                                    icon: Icons.photo_outlined,
                                    size: 50,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    _pageController.jumpToPage(1);
                                  },
                                  child: MsgBottomBarAttachButton(
                                    textColor: Colors.white,
                                    backgroundColor: Colors.lightBlue,
                                    icon: Icons.file_copy_outlined,
                                    size: 50,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    _pageController.jumpToPage(2);
                                  },
                                  child: MsgBottomBarAttachButton(
                                    textColor: Colors.white,
                                    backgroundColor: Colors.lightBlue,
                                    icon: Icons.location_on_outlined,
                                    size: 50,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    _pageController.jumpToPage(3);
                                  },
                                  child: MsgBottomBarAttachButton(
                                    textColor: Colors.white,
                                    backgroundColor: Colors.lightBlue,
                                    icon: Icons.poll_outlined,
                                    size: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
              padding: EdgeInsets.only(left: 15, right: 15),
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  // color: Colors.blue,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    decorationThickness: 0,
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Messaggio",
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.7))),
                ),
              ),
              // child: SizedBox(
              //   width: 250,
              //   child: TextField(
              //     obscureText: true,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Password',
              //     ),
              //   ),
              // ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.mic_none,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MsgBottomBarAttachButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final IconData icon;
  double size;

  MsgBottomBarAttachButton({super.key,
    required this.textColor,
    required this.backgroundColor,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Center(
        child: Icon(icon, color: textColor,),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

