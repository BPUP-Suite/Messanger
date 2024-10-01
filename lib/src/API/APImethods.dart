import 'package:http/http.dart' as http;
import 'package:messanger_bpup/faces/start/Login/loginPassword.dart';

class APImethods {
  static const APIlink = 'https://api.messanger.bpup.israiken.it';

  static Future<http.Response> emailCheckAPI(String email) async {
    final url = Uri.parse('$APIlink/user/action/access?email=$email');
    return await http.get(url);
  }

  static Future<http.Response> SignupAPI(String email, String name, String surname, String handle, String password, String confirm_password) async {
    final url = Uri.parse('$APIlink/user/action/signup?email=$email&name=$name&surname=$surname&handle=$handle&password=$password&confirm_password=$confirm_password');
    return await http.get(url);
  }

  static Future<http.Response> LoginPasswordAPI(String email, String password) async {
    final url = Uri.parse('$APIlink/user/action/login?email=$email');
    return await http.get(url);
  }
}