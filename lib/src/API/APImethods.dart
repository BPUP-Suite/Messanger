import 'package:http/http.dart' as http;

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

  static Future<http.Response> HandleAvailability(String handle) async {
    final url = Uri.parse('$APIlink/user/action/check-handle-availability?handle=$handle');
    return await http.get(url);
  }

  static Future<http.Response> LoginPasswordAPI(String email, String password) async {
    final url = Uri.parse('$APIlink/user/action/login?email=$email&password=$password');
    return await http.get(url);
  }

  static Future<http.Response> GetUserID(String apiKey) async {
    final url = Uri.parse('$APIlink/user/action/get-user-id?api_key=$apiKey');
    return await http.get(url);
  }
}
