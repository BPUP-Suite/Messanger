import 'package:bcrypt/bcrypt.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';
import 'package:messanger_bpup/src/webSocketMethods.dart';



//se metto late e non lo inizializzo esplode, bho
String localUserID = "";

getLocalUserID() async {
  localUserID = await LocalDatabaseMethods().fetchLocalUserID();
}




List<Map<String, dynamic>> _messages = []; // Store fetched messages



final ScrollController _scrollControllerMsg = ScrollController();

void scrollToTheEnd() {
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   if (_scrollController.hasClients) { // Controlla se il controller ha una posizione valida
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // });
  // Dopo che la ListView è stata costruita, scorri fino in fondo
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _scrollControllerMsg.jumpTo(_scrollControllerMsg.position.minScrollExtent);
  });
  print("Scrollato fino alla fine");
}





class ChatPanel extends StatelessWidget {
  ChatPanel({super.key, required this.chatID, required this.groupChannelName});

  final chatID;
  final String groupChannelName;

  StreamController<List<Map<String, dynamic>>> _streamController =
  StreamController.broadcast(); // Use broadcast stream for multiple listeners


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
              child: MsgListView(chatID: chatID, streamController :_streamController),
            ),
          ),

          //barra sotto che comprende graffetta, messaggio, send button
          Container(
            child: MsgBottomBar(chatID, _streamController),
          ),
        ]));
  }
}

//print dei messaggini
class MsgListView extends StatefulWidget {
  const MsgListView({super.key, required this.chatID, required this.streamController});

  final chatID;
  final streamController;

  @override
  State<MsgListView> createState() => _MsgListViewState();
}

class _MsgListViewState extends State<MsgListView> {









  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch messages initially and update UI
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchData() async {
    try {
      final messages = await LocalDatabaseMethods().fetchAllChatMessages(widget.chatID);
      _messages = messages; // Store the data
      widget.streamController.sink.add(messages); // Add fetched messages
    } catch (error) {
      // Handle error gracefully, e.g. show a snackbar
      print("Error fetching messages: $error");
    }

    //dopo aver inserito correttamente (speriamo) tutti i dati nella lista allora la scrolla fino alla fine
    // scrollToTheEnd();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff354966),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: widget.streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                controller: _scrollControllerMsg,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final reversedIndex = snapshot.data!.length - index - 1;
                  // Add print statements within buildMessage to debug its logic
                  return buildMessage(reversedIndex, snapshot.data!, context, widget.chatID);
                }
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching messages: ${snapshot.error}"), // Show error message with details
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
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
class MsgBottomBar extends StatefulWidget {
  const MsgBottomBar(this.chatID, this.streamController , {Key? key}) : super(key: key);
  final String chatID;
  final streamController;



  @override
  _MsgBottomBarState createState() => _MsgBottomBarState();
}

class _MsgBottomBarState extends State<MsgBottomBar> {
  final TextEditingController _controllerMessage = TextEditingController();
  final ValueNotifier<bool> _hasText = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controllerMessage.addListener(() {
      _hasText.value = _controllerMessage.text.isNotEmpty;
    });
  }

  void _onSend() async {
    if (_controllerMessage.text.isNotEmpty) {
      String messageSalt = BCrypt.gensalt();

      String hashedMessage = BCrypt.hashpw(
          _controllerMessage.text, messageSalt);
      print(hashedMessage);

      WebSocketMethods().WebSocketSenderMessage(
          '{"type":"send_message","text":"${_controllerMessage
              .text}","chat_id":"${widget.chatID}","salt":"$messageSalt"}');


      widget.streamController.sink.add([..._messages, {
      'sender': localUserID,
      'text': _controllerMessage.text,
      'date_time': DateTime.now().toString()}]);




      // String password = 'mySecurePassword';

      // Crea l'hash della password
      // String hashedPassword = BCrypt.hashpw(password, salt);
      // print("SALEEEEEEEEEEEEEEEEEEEEEEE: $salt");
      // print('Password originale: $password');
      // print('Password crittografata: $hashedPassword');


      // LocalDatabaseMethods.insertMessage("mammt", chatID, "prova messaggio", "sender", "2024-11-20 23:39:18.940747");


      scrollToTheEnd();


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
