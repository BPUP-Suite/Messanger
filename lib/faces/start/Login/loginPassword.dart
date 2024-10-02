import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/chatList.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';

class LoginPassword extends StatelessWidget {
  const LoginPassword({super.key, required this.emailValue});

  final emailValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        title: Text(
          "Password",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff202c3e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        alignment: Alignment.center, // Center content horizontally
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            LoginPasswordForm(emailValue),
          ],
        ),
        // child: PhoneForm(),
      ),
    );
  }
}



class LoginPasswordForm extends StatelessWidget {

  late String emailValue;
  LoginPasswordForm(String emailValue){
    this.emailValue=emailValue;
  }
  final _formKey = GlobalKey<FormState>();

  late String passwordValue;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 250,
        child: Column(
          children: <Widget>[
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(
                  color: Colors.white,
              ),
              decoration: InputDecoration(

                labelText: 'Password',

                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),


              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Per favore inserisci la tua password';
                }
                passwordValue = value;
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Form valido!')),
                    // );
                    LoginAndNavigate(context, emailValue, passwordValue);
                  }
                },
                child: Text('Invia'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



void LoginAndNavigate(BuildContext context, String emailValue, String passwordValue) async {
  String loginPasswordJson = await JsonParser().loginPasswordJson(emailValue, passwordValue);

  if (loginPasswordJson != "false") {
    print(loginPasswordJson);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatList(),
      ),
    );
  }
  else{
    print("ha ritornato TRUE, male");
  }
}
