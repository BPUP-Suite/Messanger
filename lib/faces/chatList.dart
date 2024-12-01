import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/Settings/profile.dart';
import 'package:messanger_bpup/faces/Settings/settings.dart';
import 'package:messanger_bpup/faces/chats/chatPanel.dart';
import 'package:messanger_bpup/faces/start/start.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      extendBodyBehindAppBar: true,
      //importante per potenziali effetti blur nell'appbar
      appBar: AppBar(
        title: Text(
          "Chat List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff202c3e),


        //Non fa cambiare colore alla AppBar quando la scrollbar ci va sotto
        scrolledUnderElevation: 0,

        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ChatScreen(),
      drawer: Drawer(
        backgroundColor: Color(0xff202c3e),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80, bottom: 15),
              child: CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage('https://picsum.photos/200'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Container(
                child: ListTile(
                    title: FutureBuilder(
                        future: LocalDatabaseMethods().fetchLocalUserNameAndSurname(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text("Error: ${snapshot.error}"));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text("No name and surname available"));
                          } else {
                            return Center(
                              child: Text(
                                snapshot.data!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }
                        })
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      //action button
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.lightBlue,

        animatedIcon: AnimatedIcons.menu_close,

        animatedIconTheme: IconThemeData(color: Colors.white),
        spacing: 5,
        spaceBetweenChildren: 5,
        closeManually: false,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,

        // 3 pulsantini che appaiono quando si clicca il pulsante
        children: [
          SpeedDialChild(
              child: Icon(Icons.add), shape: CircleBorder(), label: "testo"),
          SpeedDialChild(
            child: Icon(Icons.add),
            shape: CircleBorder(),
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            shape: CircleBorder(),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Column(
        children: [
          //CHAT SAVED STATICAMENTE CREATA CHE NON FA NULLA
          // Container(
          //   child: ListTile(
          //     leading: ExcludeSemantics(
          //       child: CircleAvatar(
          //         backgroundColor: Colors.lightBlue,
          //         child: Icon(
          //           Icons.bookmark_border,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //     title: Text(
          //       "Saved",
          //       style: TextStyle(
          //         color: Colors.white,
          //       ),
          //     ),
          //     subtitle: Text(
          //       "Sottotitolo",
          //       style: TextStyle(
          //         color: Colors.white.withOpacity(0.6),
          //       ),
          //     ),
          //   ),
          // ),

          // Divider(
          //   height: 1,
          //   color: Color(0xff202c3e).withOpacity(0.4),
          // ),

          FutureBuilder(
              future: LocalDatabaseMethods().fetchChats(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    // child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No chats found.'));
                } else {
                  final chats = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPanel(chatID: chat['chat_id'], groupChannelName: chat['group_channel_name'],),
                                  ),
                                );
                              },
                              child: ListTile(
                                  leading: ExcludeSemantics(
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://picsum.photos/200'),
                                    ),
                                  ),
                                  title: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: FutureBuilder(
                                              future: LocalDatabaseMethods()
                                                  .fetchUser(chat['chat_id']),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text(
                                                          'Error: ${snapshot.error}'));
                                                } else if (!snapshot.hasData ||
                                                    snapshot.data!.isEmpty) {
                                                  return Center(
                                                      child: Text(
                                                          'User not found.'));
                                                } else {
                                                  final user = snapshot.data!;
                                                  if (chat[
                                                          'group_channel_name'] !=
                                                      "") {
                                                    return Text(chat[
                                                            'group_channel_name']
                                                        .toString());
                                                  } else {
                                                    return Text(
                                                      '${user[0]['handle']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    );
                                                  }
                                                }
                                              }),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: FutureBuilder(
                                                future: LocalDatabaseMethods()
                                                    .fetchLastMessage(chat['chat_id']),
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      // child:
                                                      // CircularProgressIndicator(),
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    return Center(
                                                        child: Text(
                                                            'Error: ${snapshot.error}'));
                                                  } else if (!snapshot.hasData ||
                                                      snapshot.data!.isEmpty) {
                                                    return Center(
                                                        child: Text(
                                                            'Message not found.'));
                                                  } else {
                                                    final message = snapshot.data!;
                                                    if (message[0]['date_time'] ==
                                                        "") {
                                                      return Text("Not msgs yet");
                                                    } else {
                                                      DateTime lastMessageDateTime = DateTime.parse(message[0]['date_time']);
                                                      return Text(

                                                        '${lastMessageDateTime.hour.toString()}:${lastMessageDateTime.minute.toString()}',

                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      );
                                                    }
                                                  }
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: FutureBuilder(
                                              future: LocalDatabaseMethods()
                                                  .fetchLastMessage(chat['chat_id']),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                    // child:
                                                    // CircularProgressIndicator(),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text(
                                                          'Error: ${snapshot.error}'));
                                                } else if (!snapshot.hasData ||
                                                    snapshot.data!.isEmpty) {
                                                  return Center(
                                                      child: Text(
                                                          'Message not found.'));
                                                } else {
                                                  final message = snapshot.data!;
                                                  if (message[0]['text'] ==
                                                      "") {
                                                    return Text("Not msgs yet");
                                                  } else {
                                                    return Text(

                                                      '${message[0]['text']}',

                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    );
                                                  }
                                                }
                                              }),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            constraints: BoxConstraints(
                                                minWidth: 30, minHeight: 10),
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                              color: Color(0xff899aae),
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "123456789",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Divider(
                              height: 1,
                              color: Color(0xff202c3e).withOpacity(0.4),
                            ),
                          ],
                        );
                      });
                }
              })
        ],
      ),
    );
  }
}
