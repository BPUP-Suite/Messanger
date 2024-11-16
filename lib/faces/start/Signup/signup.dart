import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/start/emailCheck.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';
import 'dart:async';

// bool handleAvailabilityValidator = false;       //controllo nel validator
final handleAvailabilityValidator = ValueNotifier<bool>(false);

class Signup extends StatelessWidget {
  const Signup({super.key, required this.emailValue});

  final emailValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        // title: Text(
        //   "Signup",
        //   style: TextStyle(color: Colors.white),
        // ),
        centerTitle: true,
        backgroundColor: Color(0xff354966),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        alignment: Alignment.center, // Center content horizontally
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SignupForm(emailValue: emailValue),
          ],
        ),
        // child: PhoneForm(),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  final String emailValue;

  SignupForm({required this.emailValue});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _handleTextFieldKey = GlobalKey<FormFieldState>();

  Timer? _handleAvailabilityTimer;

  late String passwordValue;
  late String confirm_passwordValue;
  late String nameValue;
  late String surnameValue;
  late String handleValue;

  bool isLoading = false;

  Future<bool> checkHandleAvailability(String handle) async {
    bool handleAvailability = await JsonParser.handleAvailability(handle);

    if (handleAvailability) {
      handleAvailabilityValidator.value = true;
      print("Disponibilità handle nella funzione: $handleAvailability");
      return true;
    } else {
      handleAvailabilityValidator.value = false;
      print("Disponibilità handle nella funzione: $handleAvailability");
      return false;
    }
  }






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
              style: TextStyle(color: Colors.white),
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
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Conferma Password',
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
                  return 'Per favore ripeti la tua password';
                }
                if (value != passwordValue) {
                  return 'Non coincide con la password';
                }
                confirm_passwordValue = value;
                return null;
              },
            ),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nome',
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
                  return 'Per favore inserisci il tuo nome';
                }
                nameValue = value;
                return null;
              },
            ),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Cognome',
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
                  return 'Per favore inserisci il tuo cognome';
                }
                surnameValue = value;
                return null;
              },
            ),


            ValueListenableBuilder<bool>(
                valueListenable: handleAvailabilityValidator,
                builder: (context, handleAvailability, _) {
                  return TextFormField(
                    key: _handleTextFieldKey,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Handle',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),

                    //Quando il testo non viene modificato per 3 secondi fa una chiamata API
                    //per capire se l'handle è già in uso oppure no.
                    onChanged: (text) async {


                      handleAvailabilityValidator.value = false;

                      setState(() => isLoading = true);
                      if (_handleAvailabilityTimer?.isActive ?? false)
                        _handleAvailabilityTimer!.cancel();

                      //aspetta 3 secondi dopo che non ci sono modifiche al text field
                      // e poi manda una richiesta di check disponibilità handle
                      _handleAvailabilityTimer =
                          Timer(const Duration(milliseconds: 3000), () async {
                            final checkHandleInsideTimer = await checkHandleAvailability(text);
                            handleAvailabilityValidator.value = checkHandleInsideTimer;

                            setState(() => isLoading = false);

                            if(!checkHandleInsideTimer) {
                              _handleTextFieldKey.currentState?.validate();
                            }
                          });
                    },




                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        handleAvailabilityValidator.value = false;
                        setState(() => isLoading = false);
                        return 'Per favore inserisci il tuo handle';
                      }
                      if (!handleAvailability) {
                        print("VALIDATOR PROBLEMS - handle availability: $handleAvailability");
                        return 'Handle già in uso';
                      }

                      handleValue = value;
                      return null;
                    },
                  );
                }
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 16.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       if (_formKey.currentState!.validate()) {
            //         SignupAndNavigate(
            //           context,
            //           widget.emailValue,
            //           // Usiamo widget.emailValue poiché è definito nel StatefulWidget
            //           nameValue,
            //           surnameValue,
            //           handleValue,
            //           passwordValue,
            //           confirm_passwordValue,
            //         );
            //       }
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.lightBlue,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(100),
            //       ),
            //
            //     ),
            //     // child: Icon(Icons.check, color: Colors.white,),
            //     child: Text(
            //       "Invia",
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ValueListenableBuilder(
                  valueListenable: handleAvailabilityValidator,
                  builder: (context, handleAvailability, _) {
                    return AbsorbPointer(
                      absorbing: !handleAvailability,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            SignupAndNavigate(
                              context,
                              widget.emailValue,
                              // Usiamo widget.emailValue poiché è definito nel StatefulWidget
                              nameValue,
                              surnameValue,
                              handleValue,
                              passwordValue,
                              confirm_passwordValue,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: handleAvailability
                              ? Colors.lightBlue
                              : Colors.grey,
                          shape: isLoading
                              ? CircleBorder()
                              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        ),
                        // child: Text(
                        //   "Invia",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //   ),
                        // ),
                        child: isLoading
                            ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                            : Text(
                                "Invia",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

void SignupAndNavigate(
    BuildContext context,
    String emailValue,
    String nameValue,
    String surnameValue,
    String handleValue,
    String passwordValue,
    String confirm_passwordValue) async {
  bool signupResponse = await JsonParser.signupJson(emailValue, nameValue,
      surnameValue, handleValue, passwordValue, confirm_passwordValue);

  print("signup state: $signupResponse");

  if (signupResponse) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailCheck(),
      ),
    );
  } else {
    print("signup state: $signupResponse");
  }
}


