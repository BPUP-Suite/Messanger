import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:messanger_bpup/src/API/APImethods.dart';

class JsonParser {
  static Future<String> emailCheckJson(String email) async {
    http.Response response = await APImethods.emailCheckAPI(email);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      String emailResponse = jsonResponse['accessType'].toString();

      return emailResponse; // "login" o "signup"
    } else {
      // Gestisci l'errore della risposta
      print('Errore nella richiesta: ${response.statusCode}');
      return "";
    }
  }



  static Future<bool> signupJson(String email, String name, String surname, String handle, String password, String confirm_password) async {
    http.Response response = await APImethods.SignupAPI(email, name, surname, handle, password, confirm_password);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      bool signupResponse = jsonResponse['signedUp'];

      return signupResponse; // true o false
    } else {
      // Gestisci l'errore della risposta
      print('Errore nella richiesta: ${response.statusCode}');
      return false;
    }
  }


  //IMPORTANTE, DA SALVARE IN UNA VARIABILE NEL DISPOSITIVO \/
  static Future<String> loginPasswordJson(String email, String password) async {
    http.Response response = await APImethods.LoginPasswordAPI(email, password);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      String loginResponse = jsonResponse['api_key'].toString();

      return loginResponse; //login
    } else {
      // Gestisci l'errore della risposta
      print('Errore nella richiesta: ${response.statusCode}');
      return "";
    }
  }



  static Future<bool> handleAvailability(String handle) async {
    http.Response response = await APImethods.HandleAvailability(handle);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      bool handleAvailabilityResponse = jsonResponse['handle_available'];

      return handleAvailabilityResponse; // handle availability
    } else {
      // Gestisci l'errore della risposta
      print('Errore nella richiesta: ${response.statusCode}');
      return false;
    }
  }



  static Future<String> getUserID(String apiKey) async {
    http.Response response = await APImethods.GetUserID(apiKey);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      String userIDResponse = jsonResponse['user-id'].toString();

      return userIDResponse; //user id
    } else {
      // Gestisci l'errore della risposta
      print('Errore nella richiesta: ${response.statusCode}');
      return "";
    }
  }
}
