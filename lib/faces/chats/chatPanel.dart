import 'dart:async';
import 'package:flutter/material.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';
import 'package:messanger_bpup/src/webSocketMethods.dart';

late String localUserID;

getLocalUserID() async {
  localUserID = await LocalDatabaseMethods().fetchLocalUserID();
}

class ChatPanel extends StatelessWidget {
  ChatPanel({super.key, required this.chatID, required this.groupChannelName});

  final chatID;
  final String groupChannelName;



  @override
  Widget build(BuildContext context) {

    getLocalUserID();
    print("LOCAL USER ID - CHAT PANEL: $localUserID");
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
              FutureBuilder(
                future: LocalDatabaseMethods().fetchUser(chatID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Errore.'));
                  } else {
                    final user = snapshot.data!;
                    if (groupChannelName != "") {
                      return Text(
                        '$groupChannelName',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    } else {
                      return Text(
                        '${user[0]['handle']}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  }
                },
              ),

              // FutureBuilder(
              Spacer(),
              Icon(Icons.more_vert_rounded),
            ],
          ),
        ),

        //body
        body: Column(children: [
          //parte in cui appaiono i messaggi
          Expanded(
            child: Container(
              child: MsgListView(chatID: chatID),
            ),
          ),

          //barra sotto che comprende graffetta, messaggio, send button
          Container(
            child: MsgBottomBar(chatID),
          ),
        ]));
  }
}

//print dei messaggini
class MsgListView extends StatefulWidget {
  const MsgListView({super.key, required this.chatID});

  final chatID;

  @override
  State<MsgListView> createState() => _MsgListViewState();
}

class _MsgListViewState extends State<MsgListView> {
  static final StreamController<List<Map<String, dynamic>>> _streamController =
      StreamController();

  @override
  void initState() {
    super.initState();
    // _listenToMessages();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  //funzione orribile: OGNI 1 SEC FETCHA TUTTI I MESSAGGI, cambia 🚨
  // void _listenToMessages() async {
  //   Timer.periodic(Duration(seconds: 1), (timer) async {
  //     final messages =
  //         await LocalDatabaseMethods().fetchAllChatMessages(widget.chatID);
  //     _streamController.sink.add(messages);
  //     print(messages);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      body: Container(
        child: FutureBuilder<List<Map<String, dynamic>>> (

          future: LocalDatabaseMethods().fetchAllChatMessages(widget.chatID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No messages available"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return
                    buildMessage(index, snapshot.data!, context, widget.chatID);
                  Text("ciao");
                },
              );
            }
          },
        ),
      ),
    );
  }
}







//   // capisce se mettere il messaggio a destra o sinistra in base al sender e fa la grafichina dei msg
buildMessage(index, messages, context, chatID) {

  DateTime lastMessageDateTime = DateTime.parse(messages[index]['date_time']);

  //sender inteso come UserID
  if (messages[index]['sender'] == localUserID) {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: Container(
        constraints: BoxConstraints(
            minWidth: 10, maxWidth: MediaQuery.of(context).size.width / 1.4),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              messages[index]['text'],
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '${lastMessageDateTime.hour.toString()}:${lastMessageDateTime.minute.toString()}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
    );
  } else if (messages[index]['sender'] != localUserID) {
    return Align(
      alignment: FractionalOffset.centerLeft,
      child: Container(
        constraints: BoxConstraints(
            minWidth: 10, maxWidth: MediaQuery.of(context).size.width / 1.4),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              messages[index]['text'],
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '${lastMessageDateTime.hour.toString()}:${lastMessageDateTime.minute.toString()}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),
      ),
    );
  } else {
    // Handle other senders or return a default widget
    return print(
        "Complimenti, è difficile ottenere questo errore... e tu ci sei riuscito");
  }
}



//ORRIBILE QUESTO WIDGET, SISTEMALO PER FAVORE 🚨

//barra invio messaggio sotto
class MsgBottomBar extends StatelessWidget {
  final chatID;

  //controllo testo si/no per cambio di icona
  final TextEditingController _controllerMessage = TextEditingController();
  final ValueNotifier<bool> _hasText = ValueNotifier<bool>(false);

  MsgBottomBar(this.chatID) {
    _controllerMessage.addListener(() {
      _hasText.value = _controllerMessage.text.isNotEmpty;
    });
  }

  //fa controlli se il messaggio non è vuoto
  void _onSend() {
    if (_controllerMessage.text.isNotEmpty) {
      //changenotifier

      WebSocketMethods().WebSocketSenderMessage(
          '{"type":"send_message","text":"${_controllerMessage.text}","chat_id":"$chatID","receiver":"l"}');

      // LocalDatabaseMethods.insertMessage(50001, chatID, "prova messaggio",
      //     "sender", "2024-11-20 23:39:18.940747");

      // _streamController.sink.add(messages);

      _controllerMessage.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff202c3e),
      height: 60,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //pannello degli attachments
          Container(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Color(0xff202c3e),
                  context: context,
                  builder: (BuildContext context) {
                    PageController _sheetBottomBarChat = PageController();
                    return Container(
                      height: 500,
                      child: Column(
                        children: [
                          //barretta grigia sopra al pannello attachments
                          Container(
                            margin: EdgeInsets.all(20),
                            height: 4,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          //4 pannelli del pannello attachments
                          Expanded(
                            child: PageView(
                              controller: _sheetBottomBarChat,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.vertical(
                                        //   top: Radius.circular(10),
                                        // ),
                                        // color: Colors.yellow,
                                        ),
                                    child: Center(
                                      child: Text(
                                        'Pannello 1',
                                        style: TextStyle(fontSize: 50),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.vertical(
                                        //   top: Radius.circular(10),
                                        // ),
                                        // color: Colors.yellow,
                                        ),
                                    child: Center(
                                      child: Text(
                                        'Pannello 2',
                                        style: TextStyle(fontSize: 50),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.vertical(
                                        //   top: Radius.circular(10),
                                        // ),
                                        // color: Colors.yellow,
                                        ),
                                    child: Center(
                                      child: Text(
                                        'Pannello 3',
                                        style: TextStyle(fontSize: 50),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.vertical(
                                        //   top: Radius.circular(10),
                                        // ),
                                        // color: Colors.yellow,
                                        ),
                                    child: Center(
                                      child: Text(
                                        'Pannello 4',
                                        style: TextStyle(fontSize: 50),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //solo una linea
                          Divider(
                            height: 0.7,
                            color: Color(0xff18212f),
                          ),
                          //4 pulsanti del pannello attachments
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _sheetBottomBarChat.jumpToPage(0);
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
                                    _sheetBottomBarChat.jumpToPage(1);
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
                                    _sheetBottomBarChat.jumpToPage(2);
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
                                    _sheetBottomBarChat.jumpToPage(3);
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

          //barra centrale per i messaggi
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: 170,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                // Usa questo per i bordi esterni visibili
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: _controllerMessage,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    hintText: "Messaggio",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      // Stessa forma del container
                      borderSide: BorderSide.none, // Nessun bordo visibile
                    ),
                    isCollapsed: true, // Previene padding extra nel campo
                  ),
                ),
              ),
            ),
          ),

          //funzione controllo testo si/no per cambio di icona
          ValueListenableBuilder<bool>(
            valueListenable: _hasText,
            builder: (context, hasText, child) {
              return GestureDetector(
                onTap: _onSend,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    hasText ? Icons.send : Icons.mic_none,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              );
            },
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
  final double size;

  MsgBottomBarAttachButton({
    super.key,
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
        child: Icon(
          icon,
          color: textColor,
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
