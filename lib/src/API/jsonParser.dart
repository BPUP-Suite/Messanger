import 'dart:convert';
import 'dart:collection';
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

      String userIDResponse = jsonResponse['user_id'].toString();

      return userIDResponse; //user id
    } else {
      // Gestisci l'errore della risposta
      print('Errore nella richiesta: ${response.statusCode}');
      return "";
    }
  }

  // static Future<String> getValue(String jsonString, String jsonParameter) async {
  //
  //   Map<String, dynamic> jsonData = jsonDecode(jsonString);
  //
  //   return(jsonData[jsonParameter]);
  // }



  // Funzione per convertire una stringa JSON in una struttura dinamica con HashMap e List
  dynamic convertJsonToDynamicStructure(String jsonString) {
    // Converte la stringa JSON in una mappa o lista di base
    dynamic jsonMap = jsonDecode(jsonString);

    // Applica la conversione ricorsiva
    return _convertToDynamic(jsonMap);
  }



  // Funzione ricorsiva per navigare e convertire mappe e liste
  dynamic _convertToDynamic(dynamic value) {
    if (value is Map) {
      // Se è una mappa, converti ciascun elemento ricorsivamente e inserisci in un HashMap
      return HashMap<String, dynamic>.fromEntries(
          value.entries.map((entry) => MapEntry(entry.key, _convertToDynamic(entry.value)))
      );
    } else if (value is List) {
      // Se è una lista, converti ciascun elemento della lista ricorsivamente
      return value.map((item) => _convertToDynamic(item)).toList();
    } else {
      // Se è un valore semplice (stringa, numero, ecc.), restituiscilo direttamente
      return value;
    }
  }
}