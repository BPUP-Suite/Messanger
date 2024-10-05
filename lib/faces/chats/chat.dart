import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/chats/chatMessageObject.dart';

// late List<ChatMessage> ChatMessages = [];
// final ValueNotifier<ChatMessage> _newMessage = ValueNotifier<ChatMessage>(ChatMessage("Text", "Sender", "Receiver"));

//changenotifier
class ListModel with ChangeNotifier {
  final List<ChatMessage> _messages = <ChatMessage>[];

  List<ChatMessage> get values => _messages.toList();

  void add(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }
}

//changenotifier
ListModel _listNotifier = ListModel();

class Chat extends StatelessWidget {
  const Chat({
    super.key,
  });

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
        body: Column(children: [
          //parte in cui appaiono i messaggi
          Expanded(
            child: Container(
              child: MsgListView(
                listNotifier: _listNotifier,
              ),
            ),
          ),

          //barra sotto che comprende graffetta, messaggio, send button
          Container(
            child: MsgBottomBar(),
          ),
          //PROVA DA ELIMINARE
        ]));
  }
}

//list view dei messaggi, li stampa
class MsgListView extends StatelessWidget {
  MsgListView({
    super.key,
    required this.listNotifier,
  });

  final ListModel listNotifier;
  final ScrollController _scrollController = ScrollController();

  void autoScrollMsg() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Container(
            child: Expanded(
                child: ListenableBuilder(
                    listenable: listNotifier,
                    builder: (BuildContext context, Widget? child) {
                      List<ChatMessage> messages = listNotifier._messages;
                      return ListView.builder(
                          controller: _scrollController,
                          itemCount: messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildMessage(index, messages, context);
                          });
                    })),
          )
        ],
      ),
    );
  }

  //capisce se mettere il messaggio a destra o sinistra in base al sender e fa la grafichina dei msg
  buildMessage(index, messages, context) {
    if (messages[index].sender == "Matteo") {
      return Align(
        alignment: FractionalOffset.centerRight,
        child: Container(
          constraints: BoxConstraints(
              minWidth: 10, maxWidth: MediaQuery.of(context).size.width / 2),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          child: Text(
            messages[index].getText,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
        ),
      );
    } else if (messages[index].sender == "NonMatteo") {
      return Align(
        alignment: FractionalOffset.centerLeft,
        child: Container(
          constraints: BoxConstraints(
              minWidth: 10, maxWidth: MediaQuery.of(context).size.width / 2),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          child: Text(
            messages[index].getText,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        ),
      );
    } else {
      // Handle other senders or return a default widget
      return print(
          "Complimenti, è difficile ottenere questo errore... e tu ci sei riuscito");
    }
  }
}

//barra invio messaggio sotto
class MsgBottomBar extends StatelessWidget {
  //controllo testo si/no per cambio di icona
  final TextEditingController _controllerMessage = TextEditingController();
  final ValueNotifier<bool> _hasText = ValueNotifier<bool>(false);

  MsgBottomBar() {
    _controllerMessage.addListener(() {
      _hasText.value = _controllerMessage.text.isNotEmpty;
    });
  }

  //fa controlli se il messaggio non è vuoto
  void _onSend() {
    if (_controllerMessage.text.isNotEmpty) {
      //changenotifier
      _listNotifier
          .add(ChatMessage(_controllerMessage.text, "NonMatteo", "NonMatteo"));

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
                    PageController _pageController = PageController();
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
                              controller: _pageController,
                              children: [
                                Center(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text("Pannello 1"),
                                )),
                                Center(child: Text('Pannello 2')),
                                Center(child: Text('Pannello 3')),
                                Center(child: Text('Pannello 4')),
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

          //barra centrale per i messaggi
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(left: 15, right: 15),
              width: 170,
              height: 40,
              decoration: BoxDecoration(
                  // color: Colors.blue,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: TextField(
                  controller: _controllerMessage,
                  //controllo testo si/no per cambio di icona
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
  double size;

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
