import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String stockURL = "http://127.0.0.1:8080/greeting";

  Future<Map<String, dynamic>> fetchAlbum() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8080/greeting'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
