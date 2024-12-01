import 'package:flutter/material.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff202c3e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                //Name and Surname
                Container(
                  child: ListTile(
                    leading: ExcludeSemantics(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
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
                            return Text(
                                snapshot.data!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                            );
                          }
                        })
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color(0xff202c3e).withOpacity(0.4),
                ),
                //Email
                Container(
                  child: ListTile(
                      leading: ExcludeSemantics(
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: FutureBuilder(
                          future: LocalDatabaseMethods().fetchLocalUserEmail(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Error: ${snapshot.error}"));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text("No email available"));
                            } else {
                              return Text(
                                snapshot.data!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              );
                            }
                          })
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color(0xff202c3e).withOpacity(0.4),
                ),
                //Handle
                Container(
                  child: ListTile(
                      leading: ExcludeSemantics(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: FutureBuilder(
                          future: LocalDatabaseMethods().fetchLocalUserhandle(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Error: ${snapshot.error}"));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text("No handle available"));
                            } else {
                              return Text(
                                '@${snapshot.data!}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              );
                            }
                          })
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color(0xff202c3e).withOpacity(0.4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
